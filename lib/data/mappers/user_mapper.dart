import 'package:debt_tracker/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class UserMapper {
  UserEntity? fromModel(User? model);
}

@Injectable(as: UserMapper)
class UserMapperImpl implements UserMapper {
  @override
  UserEntity? fromModel(User? model) {
    if (model == null) {
      return null;
    }
    return UserEntity(
      email: model.email,
      name: model.displayName,
      isAnonymous: model.isAnonymous,
    );
  }
}
