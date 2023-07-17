import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.googleSignIn() = _FailureWhileGoogleSignIn;

  const factory Failure.findGoogleAccount() = _FailureWhileFindingGoogleAccount;

  const factory Failure.signOut() = _FailureWhileSignOut;

  const factory Failure.getFeed() = _FailureWhenGettingFeed;

  const factory Failure.getDebtsSummary() = _FailureWhenGettingDebtsSummary;

  const factory Failure.getDebts() = _FailureWhenGettingDebts;

  const factory Failure.getDebt() = _FailureWhenGettingDebt;

  const factory Failure.createDebt() = _FailureWhileCreatingDebt;

  const factory Failure.deleteDebt() = _FailureWhileDeletingDebt;

  const factory Failure.editDebt() = _FailureWhileEditDebt;

  const factory Failure.deleteProfile() = _FailureWhileDeletingProfile;

  const factory Failure.deleteUserData() = _FailureWhileDeletingUserData;

  const factory Failure.setSummaryCurrencyCode() = _FailureWhileSetSummaryCurrencyCode;

  const factory Failure.setSummaryStatus() = _FailureWhileSetSummaryStatus;

  const factory Failure.getSummaryStatus() = _FailureWhenGettingSummaryStatus;
}
