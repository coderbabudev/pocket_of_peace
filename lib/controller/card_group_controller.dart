import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:get/get.dart';

class CardGroupController extends GetxController {
  int currentIndex = 0;
  double currentMinValue = 0.0;
  RxBool isClose = false.obs;
  List<dynamic> cardList = [];
  final pageController = PageController();
  RxBool isNavigating = false.obs;

  Future<void> loadJsonData() async {
    String data =
        await root_bundle.rootBundle.loadString('assets/json/examples.json');
    final jsonResult = json.decode(data);
    cardList = jsonResult;
    update();
  }
}
