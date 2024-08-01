// what does the class depend on
//--AuthRepo
//how can we create a fake dependency version
//-- use Mock Tail
//how do we control what our depency do
//MockTail and Mockito

import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;
  setUp(() {
    repository = MockAuthRepository();
    usecase = CreateUser(repository);
  });
  const params = CreateUserParams.empty();
  test(
    'Should call the [AuthRepo.createUser]',
    () async {
      //Arrange
      //STUB
      when(
        () => repository.createrUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // usecase(CreateUserParams(createAt: createAt, name: name, avarter: avarter))

      //Act
      final result = await usecase(params);
      //Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.createrUser(
          createdAt: params.createAt,
          name: params.name,
          avatar: params.avartar,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
