import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/model/quiz_data_model.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';

class CardGroupController extends GetxController {
  RxDouble progressValue = 0.0.obs;
  RxDouble currentMinValue = 0.0.obs;
  RxInt currentPage = 0.obs;
  RxBool isClick = false.obs;
  RxBool isLoading = false.obs;
  List<Widget> card = [];
  List<CardItem> cardTypeList = [];
  List<CardGroup> cardList = [];
  List<CardGroup> selectedCardGroups = [];
  var yNButtonStates = <String, YesNOButtonStates>{}.obs;
  var multiChoiceCardStates = <String, List<int>>{}.obs;
  var textFieldStates = <String, List<String>>{}.obs;
  PageController pageController = PageController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> loadJsonData() async {
    String data = await root_bundle.rootBundle.loadString(Assets.catalogueJson);
    final jsonResult = json.decode(data);
    cardList =
        (jsonResult as List).map((item) => CardGroup.fromJson(item)).toList();
    update();
  }

  Rx<CardItem?> selectedCard = Rx<CardItem?>(null);

  void selectCard(CardItem card) {
    selectedCard.value = card;
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
    update();
  }

  String getTextFieldStates(String cardId, int index) {
    return textFieldStates[cardId]?[index] ?? '';
  }

  void clearCardStateValue() {
    yNButtonStates.clear();
    multiChoiceCardStates.clear();
    textFieldStates.clear();
  }

  void finishQuiz() async {
    List<CardDetail> cardDetails = selectedCardGroups.map((group) {
      return CardDetail(
        id: group.id ?? 0,
        skillCategory: group.skillCategory ?? '',
        subSkillCategory: group.subSkillCategory ?? '',
        cardList: group.cardList.map((card) {
          return CardItemDetail(
            type: card.type,
            title: card.title,
            subtitle: card.subtitle,
            index: card.index,
            placeholderTexts: card.placeholderTexts?.map((e) => e).toList(),
          );
        }).toList(),
      );
    }).toList();

    await saveQuizData(cardDetails);
  }

  Future<void> saveQuizData(List<CardDetail> cardDetails) async {
    try {
      String formattedDate =
          DateFormat('yyyy MMMM dd, hh:mm a').format(DateTime.now());
      final collection = firestore.collection('quiz_data');
      final document = collection.doc(); // Creates a new document reference
      await document.set({
        'card_details': cardDetails.map((detail) => detail.toJson()).toList(),
        'createdAt': formattedDate,
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
