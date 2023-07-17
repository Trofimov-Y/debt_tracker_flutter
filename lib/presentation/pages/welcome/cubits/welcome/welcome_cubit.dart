import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:debt_tracker/presentation/bloc/utils/cubit_mixin.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

part 'welcome_cubit.freezed.dart';

part 'welcome_state.dart';

@injectable
final class WelcomeCubit extends Cubit<WelcomeState> with CubitMixin {
  WelcomeCubit(
    this._signInWithGoogleUseCase,
  ) : super(const WelcomeState.initial());

  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  Future<void> onContinueWithGooglePressed() async {
    if (state is _Loading) return;

    emit(const WelcomeState.loading());

    final task = createTask(
      () async {
        final googleSignIn = GoogleSignIn();
        final account = await googleSignIn.signIn();
        if (account == null) throw Exception();
        return account;
      },
      (_) => const Failure.googleSignIn(),
    ).flatMap(
      (account) {
        return createTask(
          () => account.authentication,
          (_) => const Failure.findGoogleAccount(),
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
