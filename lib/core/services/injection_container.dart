import 'package:clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture/src/authentication/domain/usecases/get_users.dart';
import 'package:clean_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //app logic
  sl
    ..registerFactory(
        () => AuthenticationCubit(createUser: sl(), getUsers: sl()))
    //use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
//Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
//Data Sources

    ..registerLazySingleton<AuthenticationRemoteDataSources>(
        () => AuthRemoteDataSrcImpl(client: sl()))
//External Depenpencies
    ..registerLazySingleton(http.Client.new);
}
