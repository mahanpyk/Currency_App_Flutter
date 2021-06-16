import 'package:currency_app/api/api_setting.dart';
import 'package:currency_app/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var currencyList = [].obs;
  List time = [];

  @override
  void onInit() {
    super.onInit();
    getCurrency();
  }

  getCurrency() {
    ApiSetting apiCall = ApiSetting();
    apiCall.getRequest().then((value) {
      if (value.success != null) {
        bool success = value.success ?? false;
        if (success) {
          List list = value.body['list'];
          time = value.body['timeCurrent'];
          list.forEach((element) {
            CurrencyModel currencyModel = CurrencyModel(
              element['id'],
              element['nameFa'],
              element['price'],
              element['changeStatus'],
              element['changePercent'] == null ? 0 : element['changePercent'].toDouble(),
              element['changePrice'] == null ? 0 : element['changePrice'],
            );
            currencyList.add(currencyModel);
          });
        }
      }
      update();
    });
  }

  String priceFormatter(int price) {
    double priceToDouble = price.toDouble();
    NumberFormat numberFormat =
        NumberFormat.currency(customPattern: '###,###,###', decimalDigits: 0);
    return numberFormat.format(priceToDouble).toString();
  }

  connectionFieldBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      barrierColor: Colors.black.withOpacity(0.8),
      isScrollControlled: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            height: 224,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: Colors.black54,
            ),
            child: Column(
              children: [
                Container(
                  height: 176,
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'خطا در اتصال',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
                Container(
                  height: 48,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.black54,
                          child: InkWell(
                              splashColor: Colors.transparent,
                              enableFeedback: true,
                              child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      'تلاش مجدد',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )),
                              onTap: () {}),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  refreshAction() async {
    currencyList.clear();
    update();
    getCurrency();
  }

  itemClick(CurrencyModel currency) {
    Get.toNamed('/currencyProfile', arguments: currency);
  }
}
