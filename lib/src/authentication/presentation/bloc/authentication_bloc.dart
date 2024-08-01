import 'package:bloc/bloc.dart';
import 'package:clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture/src/authentication/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUserHandler);
  }
  final CreateUser _createUser;
  final GetUsers _getUsers;
  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
          createAt: event.createdAt, name: event.name, avartar: event.avatar),
    );
    result.fold(
        (failure) => emit(AuthenticationError(
            '${failure.statusCode} Error:${failure.message}')),
        (r) => emit(const UserCreated()));
  }

  Future<void> _getUserHandler(GetUsersEvent event, Emitter emit) async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold((failure) => AuthenticationError(failure.errorMessage),
        (users) => emit(UsersLoaded(users)));
  }
}
