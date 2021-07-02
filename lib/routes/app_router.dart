import 'package:currency_app/view/home.dart';
import 'package:get/get.dart';

class AppRouter {
  static final route = [
    GetPage(name: '/home', page: () => Home()),
  ];
}
