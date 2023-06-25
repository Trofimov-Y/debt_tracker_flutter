import 'package:debt_tracker/domain/errors/failure.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

extension PresentationFailureExtension on Failure {
  String message(BuildContext context) {
    return switch (this) {
      GoogleSignInFailedFailure() => S.of(context).googleSignInFailedFailure,
      GoogleSignInAccountNotFoundFailure() => S.of(context).googleSignInAccountNotFoundFailure,
      GeneraFailure() => S.of(context).generaFailure,
    };
  }
}
