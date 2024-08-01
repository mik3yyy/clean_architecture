import 'dart:convert';
import 'dart:io';

import 'package:clean_architecture/core/utils/typedef.dart';
import 'package:clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tModel = UserModel.empty();

  test('should be a subclass if [User] entity', () {
    expect(tModel, isA<User>());
  });
  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;
  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      //Arrange
      print(tMap);
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
      //Act
      // final result = UserModel.fromMap(map);
    });
  });
  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      //Arrange
      print(tMap);
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
      //Act
      // final result = UserModel.fromMap(map);
    });
  });
  group('toMap', () {
    test('should return a [UserModel] with the right data', () {
      //Arrange
      print(tMap);
      final result = tModel.toMap();
      expect(result, equals(tMap));
      //Act
      // final result = UserModel.fromMap(map);
    });
  });

  group('toJson', () {
    test('should return a [UserModel] with the right data', () {
      //Arrange
      print(tMap);
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "",
        "name": "",
        "createdAt": "",
      });
      expect(result, equals(tJson));
      //Act
      // final result = UserModel.fromMap(map);
    });
  });

  group("copyWith", () {
    test('should return a {UserMode;}', () {
      final result = tModel.copyWith(name: 'Paul');
      expect(result.name, 'Paul');
    });
  });
}
