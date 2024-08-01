import 'package:clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';

import 'package:clean_architecture/src/authentication/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers user;
  setUp(() {
    repository = MockAuthRepository();
    user = GetUsers(repository);
  });
  const tResponse = [User.empty()];
  test('Should  [AuthReposiry.getUsers]', () async {
    //Arrage. Stub
    when(() => repository.getUsers())
        .thenAnswer((_) async => const Right(tResponse));
    // action
    final result = await user();
//assert
    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

    verify(
      () => repository.getUsers(),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
