import 'package:currency_app/models/response_model.dart';
import 'package:dio/dio.dart';

class ApiSetting {
  Dio _dio = Dio();

  Future<ResponseModel> getRequest(String url) async {
    return _dio
        .get(
      url,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,
        receiveTimeout: 5,
      ),
    )
        .then((value) {
      ResponseModel responseModel = ResponseModel(
        value.statusCode == 200,
        value.statusCode,
        value.data,
      );
      return responseModel;
    }).catchError((e, s) {
      throw 'Connection Error';
    });
  }
}
