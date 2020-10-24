import 'dart:convert';

import 'package:currency_app/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<CurrencyModel> _currencyList = [];
  bool darkState = false;

  ThemeData _darkTheme =
      ThemeData(brightness: Brightness.dark, primaryColor: Colors.red);

  ThemeData _lightTheme =
      ThemeData(brightness: Brightness.light, primaryColor: Colors.red);

  @override
  void initState() {
    super.initState();
    _getTheme();
    _getCurrencyList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkState ? _darkTheme : _lightTheme,
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Currency'),
            leading: darkState
                ? IconButton(
                    icon: Icon(Icons.brightness_3),
                    onPressed: changeTheme,
                  )
                : IconButton(
                    icon: Icon(Icons.wb_sunny),
                    onPressed: changeTheme,
                  )),
        body: Container(
          child: _currencyList.length == 0
              ? Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text("در حال دریافت اطلاعات ... ",
                        style: TextStyle(
                            color: Color.fromRGBO(245, 144, 37, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _currencyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return generateItem(_currencyList[index]);
                  }),
        ),
      ),
    );
  }

  Widget generateItem(CurrencyModel currency) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.red[500])),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            child: LayoutBuilder(builder: (ctx, constraints) {
              return Row(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.07,
                    height: constraints.maxWidth * 0.1,
                    child: FittedBox(
                      child: currency.changeStatus == "+"
                          ? Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.03,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.26,
                    height: constraints.maxWidth * 0.1,
                    child: FittedBox(
                      child: Text(
                        currency.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.05,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.21,
                    height: constraints.maxWidth * 0.1,
                    child: FittedBox(
                      child: Text(
                        "${fixPrice(currency.price)} ريال",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.05,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxWidth * 0.08,
                    child: FittedBox(
                      child: Text(
                        '${currency.changePrice == null ? 0 : fixPrice(currency.changePrice)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: currency.changeStatus == "+"
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.06,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.18,
                    height: constraints.maxWidth * 0.08,
                    child: FittedBox(
                      child: Text(
                        '${currency.changePercent == null ? 0 : currency.changePercent.toString()} \%${currency.changeStatus == "0" ? "" : currency.changeStatus}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  String fixPrice(int price) {
    double priceToDouble = price.toDouble();
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: priceToDouble);
    return fmf.output.withoutFractionDigits.toString();
  }

  _getCurrencyList() async {
    const URL = "https://hamyarandroid.com/api?t=currency";
    Response response = await get(URL);
    if (response.statusCode == 200) {
      final currency = json.decode(response.body);
      final list = currency['list'];

      for (var i in list) {
        var currencyItem = CurrencyModel(i['id'], i['nameFa'], i['price'],
            i['changeStatus'], i['changePercent'], i['changePrice']);
        _currencyList.add(currencyItem);
      }
      setState(() {});
    }
  }

  _saveTheme() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', darkState);
  }

  _getTheme() async {
    var state = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : false;
    });
    darkState = await state;
    setState(() {});
  }

  void changeTheme() {
    setState(() {
      darkState = !darkState;
    });
    _saveTheme();
  }
}
