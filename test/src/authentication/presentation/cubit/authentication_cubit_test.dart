import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture/src/authentication/domain/usecases/get_users.dart';
import 'package:clean_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;
  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'm', statusCode: 500);
  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  test("init state", () {
    expect(cubit.state, const AuthenticationInitial());
  });
  group('get Users', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emeit [Creating User, User Created] when successful",
      build: () {
        when(() => createUser(any()))
            .thenAnswer((invocation) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avartar,
      ),
      expect: () => [
        const CreatingUser(),
        UserCreated(),
      ],
      verify: (bloc) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
    
    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emeit [Creating User, User Created] when successful",
      build: () {
        when(() => createUser(any()))
            .thenAnswer((invocation) async => const Left(tApiFailure));
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avartar,
      ),
      expect: () => [
        const CreatingUser(),
        AuthenticationError(tApiFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });
  group("get Users", () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      "get User Sucess",
      build: () {
        when(() => getUsers())
            .thenAnswer((invocation) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => [
        const GettingUsers(),
        UsersLoaded([]),
        // AuthenticationError(tApiFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
    blocTest<AuthenticationCubit, AuthenticationState>(
      "get User Sucess",
      build: () {
        when(() => getUsers())
            .thenAnswer((invocation) async => const Left(tApiFailure));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => [
        const GettingUsers(),
        AuthenticationError(tApiFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });

  tearDown(() => cubit.close());
}
