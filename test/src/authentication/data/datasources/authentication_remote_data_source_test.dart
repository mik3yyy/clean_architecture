import 'dart:convert';

import 'package:clean_architecture/core/errors/exception.dart';
import 'package:clean_architecture/core/utils/constans.dart';
import 'package:clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSources authenticationRemoteDataSources;
  setUp(() {
    client = MockClient();
    authenticationRemoteDataSources = AuthRemoteDataSrcImpl(client: client);
    registerFallbackValue(Uri());
  });
  // final response
  String createdAt = "createdAt";
  String name = "name";
  String avatar = "avatar";
  group('createUser', () {
    test('should complete with code 200 0r 201 ', () async {
      when(
        () => client.post(any(), body: any(named: 'body')),
      ).thenAnswer(
        (invocation) async => http.Response('User', 201),
      );
      final result = await authenticationRemoteDataSources.createUser;
      // (
      //   createdAt: createdAt,
      //   name: name,
      //   avatar: avatar,
      // );
      expect(
          result(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
          completes);
      verify(
        () => client.post(
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
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
    test('should throw APIExp', () {
      when(
        () => client.post(any(), body: any(named: 'body')),
      ).thenAnswer(
        (invocation) async => http.Response('Invalid Email', 400),
      );
      final methodCall = authenticationRemoteDataSources.createUser;
      expect(() => methodCall(avatar: avatar, createdAt: createdAt, name: name),
          throwsA(ApiException(message: 'Invalid Email', statusCode: 400)));

      verify(
        () => client.post(
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
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    test('should complete with code 200 0r 201 ', () async {
      when(
        () => client.get(any()),
      ).thenAnswer(
        (invocation) async => http.Response('[]', 201),
      );
      final result = await authenticationRemoteDataSources.getUsers();
      // (
      //   createdAt: createdAt,
      //   name: name,
      //   avatar: avatar,
      // );
      expect(result, <UserModel>[]);
      verify(
        () => client.get(
          Uri.parse(
            '$kBasUrl$kCreateUserEnpoint',
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
    test('should throw APIExp', () {
      when(
        () => client.get(
          any(),
        ),
      ).thenAnswer(
        (invocation) async => http.Response('Invalid Email', 400),
      );
      final methodCall = authenticationRemoteDataSources.getUsers();
      expect(() => methodCall,
          throwsA(ApiException(message: 'Invalid Email', statusCode: 400)));

      verify(
        () => client.get(
          Uri.parse(
            '$kBasUrl$kCreateUserEnpoint',
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
