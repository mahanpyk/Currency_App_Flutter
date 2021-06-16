import 'package:currency_app/view/currency_profile.dart';
import 'package:currency_app/view/home.dart';
import 'package:get/get.dart';

class AppRouter {
  static final route = [
    GetPage(name: '/home', page: () => Home()),
    GetPage(name: '/currencyProfile', page: () => CurrencyProfile()),
  ];
}
