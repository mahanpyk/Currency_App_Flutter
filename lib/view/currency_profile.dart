import 'package:currency_app/controller/currency_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyProfile extends StatelessWidget {
  CurrencyProfile({Key? key}) : super(key: key);
  final CurrencyProfileController _controller =
      Get.put(CurrencyProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          _controller.currency!.name,
          style: TextStyle(
            fontFamily: 'IRANSans',
          ),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset(
              _controller.imageList![_controller.currency!.id - 1],
              fit: BoxFit.fill,
              height: 200,
            ),
            Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              semanticContainer: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'درباره ${_controller.currency!.name}',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'IRANSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      _controller.storyList![_controller.currency!.id - 1],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontFamily: 'IRANSans',
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
