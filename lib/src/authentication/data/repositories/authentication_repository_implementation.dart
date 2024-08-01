import 'package:clean_architecture/core/errors/exception.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/utils/typedef.dart';
import 'package:clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSources);
  final AuthenticationRemoteDataSources _remoteDataSources;
  //dependancy inversion
  @override
  ResultVoid createrUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSources.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.exception(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSources.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.exception(e));
    }
  }
}
