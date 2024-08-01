import 'package:clean_architecture/core/errors/exception.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});
  final String message;

  final int statusCode;
  String get errorMessage => '${statusCode} Error $message';
  @override
  List<Object> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});
  factory ApiFailure.exception(ApiException exception) {
    return ApiFailure(
        message: exception.message, statusCode: exception.statusCode);
  }
}
