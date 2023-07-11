import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

extension PresentationFailureExtension on Failure {
  String message(BuildContext context) {
    return switch (this) {
      //TODO Add localization for all failures

      FailureWhenGettingSummaryStatus() => S.of(context).googleSignInFailedFailure,
      FailureWhileSetSummaryStatus() => S.of(context).googleSignInFailedFailure,
      FailureWhileSetSummaryCurrencyCode() => S.of(context).googleSignInFailedFailure,
      FailureWhileEditDebt() => S.of(context).googleSignInFailedFailure,
      FailureWhileDeletingDebt() => S.of(context).googleSignInFailedFailure,
      FailureWhileCreatingDebt() => S.of(context).googleSignInFailedFailure,
      FailureWhenGettingDebts() => S.of(context).googleSignInFailedFailure,
      FailureWhenGettingDebt() => S.of(context).googleSignInFailedFailure,
      FailureWhileGoogleSignIn() => S.of(context).googleSignInFailedFailure,
      FailureWhileFindingGoogleAccount() => S.of(context).googleSignInAccountNotFoundFailure,
      FailureWhileDeletingProfile() => S.of(context).generaFailure,
      FailureWhileSignOut() => S.of(context).generaFailure,
      FailureWhileDeletingUserData() => S.of(context).generaFailure,
      FailureWhenGettingSummary() => S.of(context).generaFailure,
      FailureWhenGettingFeed() => S.of(context).generaFailure,
    };
  }
}
