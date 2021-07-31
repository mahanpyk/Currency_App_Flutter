import 'dart:async';

import 'package:currency_app/providers/currencies.dart';
import 'package:currency_app/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Currencies _provider = Provider.of<Currencies>(context);
    print('build of HomeScreen');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'نرخ ارزها',
          style: TextStyle(
            fontFamily: 'IRANSans',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _provider.refreshAction(),
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: RefreshIndicator(
            onRefresh: () => _provider.refreshAction(),
            child: FutureBuilder(
                future: _provider.getCurrency(),
                builder: (ctx, dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.purple),
                            SizedBox(height: 16),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                "در حال دریافت اطلاعات ... ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'IRANSans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                    );
                  } else {
                    if (dataSnapShot.error != null) {
                      final snackBar = SnackBar(
                          content: Text(dataSnapShot.error.toString()));
                      Future.delayed(Duration.zero).then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(snackBar));
                      return Container();
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: _provider.currencyList.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              return index == 0
                                  ? Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'آخرین بروزرسانی ${_provider.time[1]} ساعت ${_provider.time[2]}',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontFamily: 'IRANSans',
                                              ),
                                            )
                                          ]),
                                    )
                                  : generateItem(
                                      _provider.currencyList[index - 1]);
                            }),
                      );
                    }
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget generateItem(CurrencyModel currency) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: currency.changeStatus == "0"
                  ? Colors.black54
                  : currency.changeStatus == "+"
                      ? Colors.green
                      : Colors.red,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              height: 48,
              child: Row(children: [
                Container(
                  width: 24,
                  height: 24,
                  child: currency.changeStatus == "0"
                      ? Icon(
                          Icons.drag_handle,
                          color: Colors.black54,
                        )
                      : currency.changeStatus == "+"
                          ? Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Wrap(children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${currency.changePercent.toString()} \%',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'IRANSans',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Wrap(children: [
                    Text(
                      currency.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'IRANSans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Wrap(children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${currency.changePrice}',
                        style: TextStyle(
                          fontFamily: 'IRANSans',
                          fontSize: 14,
                          color: currency.changeStatus == "0"
                              ? Colors.black54
                              : currency.changeStatus == "+"
                                  ? Colors.green
                                  : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Wrap(children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${currency.price} ريال",
                        style: TextStyle(
                          fontFamily: 'IRANSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
