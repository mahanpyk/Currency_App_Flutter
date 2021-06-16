import 'package:currency_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    getPages: AppRouter.route,
    initialRoute: '/home',
    title: 'Currency',
    debugShowCheckedModeBanner: false,
  ));
}
