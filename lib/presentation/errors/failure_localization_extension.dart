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
        return S.of(context).googleSignInAccountNotFoundFailure;
      },
      signOut: (value) {
        return S.of(context).signOutFailure;
      },
      getFeed: (value) {
        return S.of(context).getFeedFailure;
      },
      getDebtsSummary: (value) {
        return S.of(context).getDebtsSummaryFailure;
      },
      getDebts: (value) {
        return S.of(context).getDebtsFailure;
      },
      getDebt: (value) {
        return S.of(context).getDebtFailure;
      },
      createDebt: (value) {
        return S.of(context).createDebtFailure;
      },
      deleteDebt: (value) {
        return S.of(context).deleteDebtFailure;
      },
      editDebt: (value) {
        return S.of(context).editDebtFailure;
      },
      deleteProfile: (value) {
        return S.of(context).deleteProfileFailure;
      },
      deleteUserData: (value) {
        return S.of(context).deleteUserDataFailure;
      },
      setSummaryCurrencyCode: (value) {
        return S.of(context).setSummaryCurrencyCodeFailure;
      },
      setSummaryStatus: (value) {
        return S.of(context).setSummaryStatusFailure;
      },
      getSummaryStatus: (value) {
        return S.of(context).getSummaryStatusFailure;
      },
    );
  }
}
