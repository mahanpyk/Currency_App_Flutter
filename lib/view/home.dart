import 'package:currency_app/controller/home_controller.dart';
import 'package:currency_app/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => _controller.refreshAction(),
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
            onRefresh: () => _controller.refreshAction(),
            child: GetBuilder<HomeController>(builder: (c) {
              return _controller.currencyList.length == 0
                  ? Container(
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
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 16,
                          itemBuilder: (BuildContext context, int index) {
                            return index == 0
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'آخرین بروزرسانی ${_controller.time[1]} ساعت ${_controller.time[2]}',
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
                                    _controller.currencyList[index - 1]);
                          }),
                    );
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
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: currency.changeStatus == "+" ? Colors.green : Colors.red,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: LayoutBuilder(builder: (ctx, constraints) {
                return Container(
                  height: 48,
                  child: Row(children: [
                    Container(
                      width: 24,
                      height: 24,
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
                            '${_controller.priceFormatter(currency.changePrice)}',
                            style: TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 14,
                              color: currency.changeStatus == "+"
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
                            "${_controller.priceFormatter(currency.price)} ريال",
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
                );
              }),
            ),
          ),
          onTap: () => _controller.itemClick(currency),
        ),
      ),
    );
  }
}
