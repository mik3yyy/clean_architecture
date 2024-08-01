import 'package:bloc/bloc.dart';
import 'package:clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture/src/authentication/domain/usecases/get_users.dart';
import 'package:clean_architecture/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/create_user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
      {required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
        createAt: createdAt,
        name: name,
        avartar: avatar,
      ),
    );
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (r) => emit(
        const UserCreated(),
      ),
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (users) => emit(UsersLoaded(users)));
  }
}
