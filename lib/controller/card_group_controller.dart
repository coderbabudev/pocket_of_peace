import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:get/get.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/services/shared_prefrences_service.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';

class CardGroupController extends GetxController {
  RxDouble progressValue = 0.0.obs;
  RxDouble currentMinValue = 0.0.obs;
  RxInt pageIndex = 0.obs;
  List<int> selectedCard = [];
  List<CardItem> cardTypeList = [];
  List<Widget> card = [];

  RxBool isClick = false.obs;
  RxBool noSelect = false.obs;
  RxBool yesSelect = false.obs;

  List<CardGroup> cardList = [];
  List<CardGroup> mandatoryCategories = [];

  PageController pageController = PageController();

  var textValues = <String, String>{}.obs;

  String _generateKey(int cardIndex, int fieldIndex) {
    return 'card_$cardIndex$fieldIndex';
  }

  String getTextValue(int cardIndex, int fieldIndex) {
    return textValues[_generateKey(cardIndex, fieldIndex)] ?? '';
  }

  void setTextValue(int cardIndex, int fieldIndex, String value) {
    textValues[_generateKey(cardIndex, fieldIndex)] = value;
  }

  Future<void> loadJsonData() async {
    try {
      String data =
          await root_bundle.rootBundle.loadString(Assets.catalogueJson);
      final jsonResult = json.decode(data);
      cardList =
          (jsonResult as List).map((item) => CardGroup.fromJson(item)).toList();

      update();
    } catch (e) {
      throw e.toString();
    }
    update();
  }

  List<CardGroup> selectCards(List<CardGroup> cardGroups, int totalCards) {
    Map<String, int> skillCategoryCount = {};
    List<CardGroup> selected = [];

    for (var cardGroup in cardGroups) {
      var skillCategory = cardGroup.skillCategory;
      if (skillCategoryCount[skillCategory] == null) {
        skillCategoryCount[skillCategory.toString()] = 0;
      }

      if (skillCategoryCount[skillCategory]! < 2) {
        selected.add(cardGroup);
        skillCategoryCount[skillCategory.toString()] =
            skillCategoryCount[skillCategory]! + 1;
      }

      if (selected.length >= totalCards) break;
    }

    return selected;
  }

  void initializeMandatoryCategories(int n) {
    mandatoryCategories = [
      selectCards(cardList, 1).firstWhere(
        (group) => group.skillCategory == "boost_intro",
        orElse: () => CardGroup(skillCategory: "boost_intro", cardList: []),
      ),
      selectCards(cardList, 1).firstWhere(
        (group) => group.skillCategory == "surrounding_intro",
        orElse: () =>
            CardGroup(skillCategory: "surrounding_intro", cardList: []),
      ),
      selectCards(cardList, n).firstWhere(
        (group) => group.skillCategory == "surrounding",
        orElse: () => CardGroup(skillCategory: "surrounding", cardList: []),
      ),
      selectCards(cardList, 1).firstWhere(
        (group) => group.skillCategory == "surrounding_outro",
        orElse: () =>
            CardGroup(skillCategory: "surrounding_outro", cardList: []),
      ),
      selectCards(cardList, 1).firstWhere(
        (group) => group.skillCategory == "breathing_middle",
        orElse: () =>
            CardGroup(skillCategory: "breathing_middle", cardList: []),
      ),
      selectCards(cardList, 1).firstWhere(
        (group) => group.skillCategory == "body_intro",
        orElse: () => CardGroup(skillCategory: "body_intro", cardList: []),
      ),
      selectCards(cardList, n).firstWhere(
        (group) => group.skillCategory == "body",
        orElse: () => CardGroup(skillCategory: "body", cardList: []),
      ),
      selectCards(cardList, 1).firstWhere(
        (group) => group.skillCategory == "body_outro",
        orElse: () => CardGroup(skillCategory: "body_outro", cardList: []),
      ),
      selectCards(cardList, 1).firstWhere(
        (group) => group.skillCategory == "breathing_end",
        orElse: () => CardGroup(skillCategory: "breathing_end", cardList: []),
      ),
      selectCards(cardList, 1).firstWhere(
        (group) => group.skillCategory == "final",
        orElse: () => CardGroup(skillCategory: "final", cardList: []),
      ),
    ];
  }

  Future<void> loadSelectedValue() async {
    String selectedValue = PreferenceUtils.getYesNoBtnValue('selected_value');
    if (selectedValue == 'Yes') {
      yesSelect.value = true;
      noSelect.value = false;
    } else if (selectedValue == 'No') {
      noSelect.value = true;
      yesSelect.value = false;
    }
    update();
  }

  Future<void> saveSelectedValue() async {
    String selectedValue;
    if (yesSelect.value) {
      selectedValue = 'Yes';
    } else if (noSelect.value) {
      selectedValue = 'No';
    } else {
      selectedValue = 'None'; // Default case, if neither is selected
    }
    await PreferenceUtils.setYesNoBtnValue('selected_value', selectedValue);
    update();
  }
}
