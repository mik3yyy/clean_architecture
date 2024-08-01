import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/core/utils/typedef.dart';
import 'package:clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture call(CreateUserParams params) async => _repository.createrUser(
        createdAt: params.createAt,
        name: params.name,
        avatar: params.avartar,
      );
}

class CreateUserParams extends Equatable {
  final String createAt;
  final String name;
  final String avartar;

  const CreateUserParams(
      {required this.createAt, required this.name, required this.avartar});

  const CreateUserParams.empty()
      : this(
          createAt: '_empty.string',
          name: '',
          avartar: '',
        );
  @override
  // TODO: implement props
  List<Object?> get props => [name, createAt, avartar];
}
