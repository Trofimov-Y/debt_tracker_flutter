import 'package:bloc/bloc.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

part 'welcome_cubit.freezed.dart';
part 'welcome_state.dart';

@Injectable()
class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit(
    this._firebaseAuth,
    this._appRouter,
  ) : super(const WelcomeState.data());

  final AppRouter _appRouter;
  final FirebaseAuth _firebaseAuth;

  void onContinueWithGooglePressed() {
    state.mapOrNull(
      data: (_) async {
        emit(const WelcomeState.loading());
        try {
          final googleSignIn = GoogleSignIn();
          final crendational = await googleSignIn.signIn();
          if (crendational != null) {
            final googleAuth = await crendational.authentication;
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            final result = await _firebaseAuth.signInWithCredential(credential);
            if (result.user != null) {
              _appRouter.replaceAll([const HomeRoute()]);
            }
          }
        } catch (e) {
          emit(const WelcomeState.data());
        }
      },
    );
  }

  void onSignAsGuestPressed() {
    state.mapOrNull(
      data: (_) async {
        emit(const WelcomeState.loading());
        try {
          final result = await _firebaseAuth.signInAnonymously();
          if (result.user != null) {
            _appRouter.replaceAll([const HomeRoute()]);
          }
        } catch (e) {
          emit(const WelcomeState.data());
        }
      },
    );
  }
}
