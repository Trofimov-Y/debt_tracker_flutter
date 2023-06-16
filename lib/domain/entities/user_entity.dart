import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    String? email,
    String? name,
    required bool isAnonymous,
  }) = _UserEntity;
}
