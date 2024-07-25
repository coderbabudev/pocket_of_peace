import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:get/get.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';

class CardGroupController extends GetxController {
  double progressValue = 0.0;
  RxDouble currentMinValue = 0.0.obs;
  RxBool isClose = false.obs;
  List<CardGroup> cardList = [];
  final pageController = PageController();
  RxBool isClick = false.obs;

  List<CardItem> cardListSorted(List<CardGroup> cardGroups) {
    return cardGroups.expand((group) => group.cardList).toList();
  }

  // closeExitDialog() {
  //   isClose.value = false;
  //   update();
  // }

  Future<void> loadJsonData() async {
    try {
      String data = await root_bundle.rootBundle.loadString(Assets.exampleJson);
      final jsonResult = json.decode(data);
      cardList =
          (jsonResult as List).map((item) => CardGroup.fromJson(item)).toList();

      update();
    } catch (e) {
      log('Error Parsing JSON: $e');
    }
    update();
  }
}
