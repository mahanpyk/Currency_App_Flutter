class ResponseModel {
  var body;
  int? statusCode;
  bool? success;

  ResponseModel(
    this.success,
    this.statusCode,
    this.body,
  );
}
