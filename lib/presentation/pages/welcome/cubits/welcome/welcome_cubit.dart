import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

part 'welcome_cubit.freezed.dart';

part 'welcome_state.dart';

@Injectable()
final class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit(
    this._signInWithGoogleUseCase,
    this._logger,
  ) : super(const WelcomeState.initial());

  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  final Logger _logger;

  Future<void> onContinueWithGooglePressed() async {
    if (state is _Loading) return;
    emit(const WelcomeState.loading());

    final task = TaskEither<Failure, GoogleSignInAccount>.tryCatch(
      () async {
        final googleSignIn = GoogleSignIn();
        final account = await googleSignIn.signIn();
        if (account == null) throw Exception();
        return account;
      },
      (error, stackTrace) {
        _logger.w(error.toString(), error, stackTrace);
        return const GoogleSignInFailedFailure();
      },
    ).flatMap(
      (account) {
        return TaskEither<Failure, GoogleSignInAuthentication>.tryCatch(
          () => account.authentication,
          (error, stackTrace) {
            _logger.w(error.toString(), error, stackTrace);
            return const GoogleSignInAccountNotFoundFailure();
          },
        ).flatMap(
          (auth) {
            return TaskEither<Failure, void>(
              () => _signInWithGoogleUseCase(idToken: auth.idToken, accessToken: auth.accessToken),
            );
          },
        );
      },
    );

    task.run().then(
      (result) {
        result.fold(
          (failure) => emit(WelcomeState.error(failure)),
          (_) => emit(const WelcomeState.success()),
        );
      },
    );
  }
}
