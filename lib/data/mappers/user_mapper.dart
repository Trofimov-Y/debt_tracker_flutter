import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:debt_tracker/data/models/user_model.dart';
import 'package:debt_tracker/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

part 'user_mapper.g.dart';

@Injectable()
@AutoMappr([
  MapType<UserEntity, UserModel>(),
  MapType<UserModel, UserEntity>(),
])
class UserMapper extends $UserMapper {}
