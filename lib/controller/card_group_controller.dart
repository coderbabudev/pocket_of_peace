import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:get/get.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/model/save_value_model.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';

class CardGroupController extends GetxController {
  RxDouble progressValue = 0.0.obs;
  RxDouble currentMinValue = 0.0.obs;
  RxInt currentPage = 0.obs;

  RxBool isClick = false.obs;

  List<Widget> card = [];
  List<CardGroup> cardList = [];
  List<CardItem> cardTypeList = [];
  List<int> selectedMultiChoiceCard = [];
  List<CardGroup> selectedCardGroups = [];

  var textValues = <String, String>{}.obs;
  var cardStates = <String, YesNOButtonStatus>{}.obs;
  PageController pageController = PageController();

  Future<void> loadJsonData() async {
    String data = await root_bundle.rootBundle.loadString(Assets.catalogueJson);
    final jsonResult = json.decode(data);
    cardList =
        (jsonResult as List).map((item) => CardGroup.fromJson(item)).toList();
    update();
  }

  void initializeMandatoryCategories(int n) {
    selectedCardGroups = [
      ...selectCards(cardList, n, skillCategory: "body"),
      ...selectCards(cardList, n, skillCategory: "surroundings"),
      ...selectCards(cardList, 1, skillCategory: "boost_intro"),
      ...selectCards(cardList, 1, skillCategory: "surrounding_intro"),
      ...selectCards(cardList, 1, skillCategory: "surrounding_outro"),
      ...selectCards(cardList, 1, skillCategory: "breathing_middle"),
      ...selectCards(cardList, 1, skillCategory: "body_intro"),
      ...selectCards(cardList, 1, skillCategory: "body_outro"),
      ...selectCards(cardList, 1, skillCategory: "breathing_end"),
      ...selectCards(cardList, 1, skillCategory: "final"),
    ].where((group) => group.cardList.isNotEmpty).toList();

    for (var cardGroup in selectedCardGroups) {
      print('Added skill_category: ${cardGroup.skillCategory}');
    }
  }

  List<CardGroup> selectCards(List<CardGroup> cardGroups, int totalCards,
      {String? skillCategory}) {
    var filteredGroups = skillCategory == null
        ? cardGroups
        : cardGroups
            .where((group) => group.skillCategory == skillCategory)
            .toList();
    return filteredGroups.take(totalCards).toList();
  }

  void updateCardState(String id, bool isYesSelected, bool isNoSelected) {
    cardStates[id] = YesNOButtonStatus(
        id: id, isYesSelected: isYesSelected, isNoSelected: isNoSelected);
  }

  getCardState(String id) {
    return cardStates[id] ?? YesNOButtonStatus(id: id);
  }
}
