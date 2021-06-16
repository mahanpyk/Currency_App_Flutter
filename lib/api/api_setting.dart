import 'package:currency_app/model/responseModel.dart';
import 'package:dio/dio.dart';

class ApiSetting {
  Dio _dio = Dio();

  Future<ResponseModel> getRequest() async {
    return _dio
        .get(
      'https://hamyarandroid.com/api?t=currency',
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
        receiveDataWhenStatusError: true,
        validateStatus: (_) => true,
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
