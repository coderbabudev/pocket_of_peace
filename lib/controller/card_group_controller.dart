import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:get/get.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/model/quiz_data_model.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';

class CardGroupController extends GetxController {
  RxDouble progressValue = 0.0.obs;
  RxDouble currentMinValue = 0.0.obs;
  RxInt currentPage = 0.obs;
  RxBool isClick = false.obs;
  RxBool isSelected = false.obs;
  List<Widget> card = [];
  List<CardItem> cardTypeList = [];
  List<CardGroup> cardList = [];
  List<CardGroup> selectedCardGroups = [];
  List<CardDetail> quizDataList = [];
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

  RxnBool manageSwipe() {
    CardItem currentCard = cardTypeList[currentPage.value];
    if (currentCard.type == 'MultipleChoiceCard') {
      return RxnBool(
          (multiChoiceCardStates["card_${currentPage.value}"]?.isNotEmpty ??
              false));
    } else if (currentCard.type == 'TextCard') {
      return RxnBool(
          (textFieldStates["card_${currentPage.value}"]?.isNotEmpty ?? false));
    } else if (currentCard.type == 'YesNoCard') {
      return RxnBool((yNButtonStates["card_${currentPage.value}"]
                  ?.isYesSelected ??
              false) ||
          (yNButtonStates["card_${currentPage.value}"]?.isNoSelected ?? false));
    }
    return RxnBool();
  }

  void initializeMandatoryCategories(int n) {
    selectedCardGroups = [
      ...selectCards(cardList, 1, skillCategory: "boost_intro"),
      ...selectCards(cardList, 1, skillCategory: "surrounding_intro"),
      ...selectCards(cardList, n, skillCategory: "surroundings"),
      ...selectCards(cardList, 1, skillCategory: "surrounding_outro"),
      ...selectCards(cardList, 1, skillCategory: "breathing_middle"),
      ...selectCards(cardList, 1, skillCategory: "body_intro"),
      ...selectCards(cardList, n, skillCategory: "body"),
      ...selectCards(cardList, 1, skillCategory: "body_outro"),
      ...selectCards(cardList, 1, skillCategory: "breathing_end"),
      ...selectCards(cardList, 1, skillCategory: "final"),
    ].where((group) => group.cardList.isNotEmpty).toList();
    selectedCardGroups.shuffle(Random());
  }

  List<CardGroup> selectCards(List<CardGroup> cardGroups, int totalCards,
      {String? skillCategory}) {
    var filteredGroups = skillCategory == null
        ? cardGroups
        : cardGroups
            .where((group) => group.skillCategory == skillCategory)
            .toList();
    filteredGroups.shuffle(Random());
    return filteredGroups.take(totalCards).toList();
  }

  void updateYNButtonState(String id, bool isYesSelected, bool isNoSelected) {
    yNButtonStates[id] = YesNOButtonStates(
      id: id,
      isYesSelected: isYesSelected,
      isNoSelected: isNoSelected,
    );
    update();
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

  void updateTextFieldStates(String cardId, int index, String value) {
    if (!textFieldStates.containsKey(cardId)) {
      textFieldStates[cardId] = [];
    }
    if (textFieldStates[cardId]!.length <= index) {
      textFieldStates[cardId]!.add(value);
    } else {
      textFieldStates[cardId]![index] = value;
    }
    update();
  }

  getYNButtonState(String id) {
    return yNButtonStates[id] ?? YesNOButtonStates(id: id);
  }

  List<int> getMultiChoiceCardState(String cardId) {
    return multiChoiceCardStates[cardId] ?? [];
  }

  String getTextFieldStates(String cardId, int index) {
    return textFieldStates[cardId]?[index] ?? '';
  }

  void clearCardStateValue() {
    yNButtonStates.clear();
    multiChoiceCardStates.clear();
    textFieldStates.clear();
  }

/*bool isMultipleChoiceCardCompleted(String cardId) {
    return multiChoiceCardStates[cardId]?.isNotEmpty ?? false;
  }

  bool isTextCardCompleted(String cardId, int textFieldCount) {
    if (textFieldStates[cardId] == null) return false;
    for (int i = 0; i < textFieldCount; i++) {
      if (textFieldStates[cardId]![i].isEmpty) return false;
    }
    return true;
  }

  bool isYesNoCardCompleted(String cardId) {
    var state = yNButtonStates[cardId];
    return state?.isYesSelected == true || state?.isNoSelected == true;
  }

  bool isCardCompleted(CardItem card,String cardID) {
    switch (card.type) {
      case 'MultipleChoiceCard':
        return isMultipleChoiceCardCompleted(cardID);
      case 'TextCard':
        return isTextCardCompleted(cardID, card.numTextFields!);
      case 'YesNoCard':
        return isYesNoCardCompleted(cardID);
      default:
        return true; // If card type doesn't require action
    }
  }*/
}
