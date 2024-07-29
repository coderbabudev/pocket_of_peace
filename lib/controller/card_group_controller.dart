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
  List<CardGroup> selectedCardGroups = [];

  var yNButtonStates = <String, YesNOButtonStates>{}.obs;
  var multiChoiceCardStates = <String, List<int>>{}.obs;
  var textFieldStates = <String, List<String>>{}.obs;

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
      ...selectCards(cardList, 1, skillCategory: "boost_intro"),
      ...selectCards(cardList, 1, skillCategory: "surrounding_intro"),
      ...selectCards(cardList, n, skillCategory: "surroundings"),
      ...selectCards(cardList, 1, skillCategory: "surrounding_outro"),
      ...selectCards(cardList, 1, skillCategory: "body_intro"),
      ...selectCards(cardList, 1, skillCategory: "breathing_middle"),
      ...selectCards(cardList, 1, skillCategory: "body_outro"),
      ...selectCards(cardList, n, skillCategory: "body"),
      ...selectCards(cardList, 1, skillCategory: "breathing_end"),
      ...selectCards(cardList, 1, skillCategory: "final"),
    ].where((group) => group.cardList.isNotEmpty).toList();
  }

  List<CardGroup> selectCards(List<CardGroup> cardGroups, int totalCards,
      {String? skillCategory}) {
    var filteredGroups = skillCategory == null
        ? cardGroups
        : cardGroups
            .where((group) => group.skillCategory == skillCategory)
            .toList();
    filteredGroups.shuffle();
    return filteredGroups.take(totalCards).toList();
  }

  void updateYNButtonState(String id, bool isYesSelected, bool isNoSelected) {
    yNButtonStates[id] = YesNOButtonStates(
      id: id,
      isYesSelected: isYesSelected,
      isNoSelected: isNoSelected,
    );
  }

  getYNButtonState(String id) {
    return yNButtonStates[id] ?? YesNOButtonStates(id: id);
  }

  void updateMultiChoiceCardState(
      String cardId, int optionIndex, int maxSelection) {
    if (!multiChoiceCardStates.containsKey(cardId)) {
      multiChoiceCardStates[cardId] = [];
    }

    if (multiChoiceCardStates[cardId]!.contains(optionIndex)) {
      multiChoiceCardStates[cardId]!.remove(optionIndex);
    } else if (multiChoiceCardStates[cardId]!.length < maxSelection) {
      multiChoiceCardStates[cardId]!.add(optionIndex);
    }
  }

  List<int> getMultiChoiceCardState(String cardId) {
    return multiChoiceCardStates[cardId] ?? [];
  }

  void updateTextFieldStates(String cardId, int index, String value) {
    if (!textFieldStates.containsKey(cardId)) {
      textFieldStates[cardId] = [];
    }
    if (textFieldStates[cardId]!.length <= index) {
      textFieldStates[cardId]!.add(value);
    } else {
      textFieldStates[cardId]![index] = value;
    }
    update(); // Notify listeners about the update
  }

  String getTextFieldStates(String cardId, int index) {
    return textFieldStates[cardId]?[index] ?? '';
  }

  void clearCardStateValue() {
    yNButtonStates.clear();
    multiChoiceCardStates.clear();
    textFieldStates.clear();
  }
}
