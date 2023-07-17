import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

extension PresentationFailureExtension on Failure {
  String message(BuildContext context) {
    return map(
      googleSignIn: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      findGoogleAccount: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      signOut: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      getFeed: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      getDebtsSummary: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      getDebts: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      getDebt: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      createDebt: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      deleteDebt: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      editDebt: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      deleteProfile: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      deleteUserData: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      setSummaryCurrencyCode: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      setSummaryStatus: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
      getSummaryStatus: (value) {
        return S.of(context).googleSignInFailedFailure;
      },
    );
  }
}
