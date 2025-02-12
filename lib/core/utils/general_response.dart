class ApiResult {
  bool hasData = false;
  dynamic data;
  Failure? failure;
  ApiResult({this.hasData = false, this.data, this.failure});

}

class Failure {
  int code;
  String message;

  Failure(this.code, this.message);
}
