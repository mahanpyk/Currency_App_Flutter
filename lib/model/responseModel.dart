class ResponseModel {
  var body;
  int? statusCode;
  bool? success;
  String? message;

  ResponseModel(
    this.success,
    this.statusCode,
    this.body,
  );
}
