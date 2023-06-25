// import 'package:debt_tracker/domain/entities/user_entity.dart';
// import 'package:debt_tracker/domain/repositories/authentication_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// @GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
// import 'authentication_repository_test.mocks.dart';
//
// void main() {
//   final repository = MockAuthenticationRepository();
//
//   group('Authentication Changes Group', () {
//     const testEntity = UserEntity(
//       isAnonymous: true,
//       email: 'example@example.com',
//       name: 'testName',
//     );
//
//     test('Should return a stream of UserEntity', () {
//       when(repository.getAuthenticationChanges()).thenAnswer(
//         (_) => Stream.fromIterable([testEntity]),
//       );
//       final userEntity = repository.getAuthenticationChanges();
//       expect(userEntity, emitsInOrder([testEntity]));
//     });
//
//     test('Should return a stream of UserEntity with isAnonymous', () {
//       when(repository.getAuthenticationChanges()).thenAnswer(
//         (_) => Stream.fromIterable([testEntity.copyWith(isAnonymous: true)]),
//       );
//       final userEntity = repository.getAuthenticationChanges();
//       expect(userEntity, emitsInOrder([testEntity.copyWith(isAnonymous: true)]));
//     });
//
//     test('Should a throw an error if authentication fails', () {
//       when(repository.getAuthenticationChanges()).thenThrow(Exception('Authentication failed'));
//       try {
//         repository.getAuthenticationChanges();
//       } catch (exception) {
//         expect(exception, isInstanceOf<Exception>());
//       }
//     });
//   });
// }
