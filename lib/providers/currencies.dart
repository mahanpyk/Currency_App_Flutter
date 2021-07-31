import 'package:currency_app/api/api_setting.dart';
import 'package:currency_app/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Currencies extends ChangeNotifier {
  List _currencyList = [];
  List _time = [];

  List get currencyList => _currencyList;

  List get time => _time;

  getCurrency() async {
    final String _url = 'https://hamyarandroid.com/api?t=currency';
    final ApiSetting _apiCall = ApiSetting();
    try {
      var response = await _apiCall.getRequest(_url);
      if (response.success != null) {
        if (response.success ?? false) {
          List list = response.body['list'];
          _time = response.body['timeCurrent'];
          list.forEach((element) {
            CurrencyModel currencyModel = CurrencyModel(
              id: element['id'],
              name: element['nameFa'],
              price: priceFormatter(element['price']),
              changeStatus: element['changeStatus'],
              changePercent: element['changePercent'] == null
                  ? 0
                  : element['changePercent'].toDouble(),
              changePrice: priceFormatter(
                  element['changePrice'] == null ? 0 : element['changePrice']),
            );
            _currencyList.add(currencyModel);
          });
        } else {
          throw 'response not valid';
        }
      }
    } catch (e) {
      throw 'no response available';
    }
  }

  String priceFormatter(int price) {
    final String _customPattern = '###,###,###';
    final double priceToDouble = price.toDouble();
    final NumberFormat numberFormat =
        NumberFormat.currency(customPattern: _customPattern, decimalDigits: 0);
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
    _currencyList.clear();
notifyListeners();
  }
}
