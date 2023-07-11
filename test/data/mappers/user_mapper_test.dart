// import 'package:debt_tracker/data/mappers/user_mapper.dart';
//
// import 'package:debt_tracker/data/models/user_model.dart';
//
// import 'package:debt_tracker/domain/entities/user_entity.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//   final userMapper = UserMapper();
//
//   group('User Mapping Group', () {
//     final testModel = UserModel(
//       isAnonymous: true,
//       email: 'example@example.com',
//       name: 'testName',
//     );
//     const testEntity = UserEntity(
//       isAnonymous: true,
//       email: 'example@example.com',
//       name: 'testName',
//     );
//
//     test('Should convert to UserEntity', () async {
//       final userEntity = userMapper.tryConvert<UserModel, UserEntity>(testModel);
//
//       expect(userEntity, isA<UserEntity>());
//       expect(userEntity?.isAnonymous, testModel.isAnonymous);
//       expect(userEntity?.email, testModel.email);
//       expect(userEntity?.name, testModel.name);
//     });
//
//     test('Should convert to UserModel', () async {
//       final userModel = userMapper.tryConvert<UserEntity, UserModel>(testEntity);
//
//       expect(userModel, isA<UserModel>());
//       expect(userModel?.isAnonymous, testEntity.isAnonymous);
//       expect(userModel?.email, testEntity.email);
//       expect(userModel?.name, testEntity.name);
//     });
//
//     test('Should return null when UserModel is null', () async {
//       final userEntity = userMapper.tryConvert<UserModel, UserEntity>(null);
//
//       expect(userEntity, isNull);
//     });
//
//     test('Should return null when UserEntity is null', () async {
//       final userModel = userMapper.tryConvert<UserEntity, UserModel>(null);
//
//       expect(userModel, isNull);
//     });
//   });
// }
