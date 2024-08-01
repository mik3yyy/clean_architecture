import 'dart:convert';

import 'package:clean_architecture/core/errors/exception.dart';
import 'package:clean_architecture/core/utils/constans.dart';
import 'package:clean_architecture/core/utils/typedef.dart';
import 'package:clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSources {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  Future<List<UserModel>> getUsers();
}

const kCreateUserEnpoint = '/users';
const kGetUsersEnpoint = '/';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSources {
  final http.Client _client;

  AuthRemoteDataSrcImpl({required http.Client client}) : _client = client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(
          '$kBasUrl$kCreateUserEnpoint',
        ),
        body: jsonEncode(
          {
            "createdAt": createdAt,
            "name": name,
            "avatar": avatar,
          },
        ),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
    // return
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBasUrl$kCreateUserEnpoint',
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList(); // jsonDecode(response.body) as List<UserModel>;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: "Error", statusCode: 505);
    }
  }
}
