import 'package:flutter/cupertino.dart';

abstract class ApiResult<T> {
  static ApiResult<T> success<T>(T data) {
    return Success(data: data);
  }
  static ApiResult<T> error<T>(dynamic error) {
    return Error(error: error);
  }
  static ApiResult<T> loading<T>() {
    return Loading();
  }
  static ApiResult loaded<T>() {
    return Loaded();
  }
}

class Success<T> extends ApiResult<T> {
  T? data;
  Success({required this.data});
}

class Error<T> extends ApiResult<T> {
  dynamic error;
  Error({required this.error});
}

class Loading<T> extends ApiResult<T> {}
class Loaded<T> extends ApiResult<T> {}
