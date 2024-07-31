import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/model/quiz_data_model.dart';
import 'package:pocket_of_peace/screens/finish_screen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:pocket_of_peace/widgets/common_build_widget.dart';
import 'package:pocket_of_peace/widgets/multiple_choice_card_widget.dart';
import 'package:pocket_of_peace/widgets/statement_card_widget.dart';
import 'package:pocket_of_peace/widgets/text_card_widget.dart';
import 'package:pocket_of_peace/widgets/yes_no_card_widget.dart';

class ShowCardScreen extends StatefulWidget {
  const ShowCardScreen({
    super.key,
    this.minuteValue = 0.0,
  });

  final double minuteValue;

  @override
  State<ShowCardScreen> createState() => _ShowCardScreenState();
}

class _ShowCardScreenState extends State<ShowCardScreen> {
  CardGroupController controller = Get.put(CardGroupController());

  @override
  void initState() {
    super.initState();
    controller.initializeMandatoryCategories(widget.minuteValue.toInt());
    controller.cardTypeList = controller.selectedCardGroups.expand((group) {
      for (var element in group.cardList) {
        element.idMain = group.id;
        element.skillCategoryMain = group.skillCategory;
        element.subSkillCategoryMain = group.subSkillCategory;
      }
      return group.cardList;
    }).toList();
    controller.card = [];
    controller.quizDataList = [];
    controller.cardTypeList.shuffle(Random());
    controller.card.addAll(data(controller.cardTypeList));
    controller.quizDataList = List.generate(
      controller.card.length - 1,
      (index) => CardDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showExitDialog(context, controller);
        return false;
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              Assets.mainBg,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => showExitDialog(context, controller),
                      child: Image.asset(
                        Assets.closeIcon,
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ).paddingOnly(right: 22),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: controller.progressValue.value,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: AppColors.primaryColor,
                    minHeight: 10,
                    valueColor: AlwaysStoppedAnimation(AppColors.lightBlue),
                    color: AppColors.lightGreen,
                  ).paddingOnly(left: 29, right: 25, bottom: 50),
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.card.length,
                      physics: controller.currentPage.value ==
                              controller.card.length - 1
                          ? const NeverScrollableScrollPhysics()
                          : controller.manageSwipe().value == null ||
                                  controller.manageSwipe().value == true
                              ? const ScrollPhysics()
                              : NeverScrollableScrollPhysics(),
                      itemBuilder: (context, groupIndex) {
                        return controller.card[groupIndex];
                      },
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) async {
                        controller.currentPage.value = index;
                        setState(() {
                          controller.progressValue.value =
                              (index + 1) / controller.card.length;
                        });
                        CardItem currentCard = controller.cardTypeList[index];
                        if (currentCard.type == 'MultipleChoiceCard') {
                          print(
                              'selected :- ${controller.multiChoiceCardStates}');
                        }
                      },
                    ),
                  )
                ],
              ).paddingSymmetric(vertical: 20),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> data(List<CardItem> flatCardList) {
    return [
      ...List.generate(flatCardList.length, (index) {
        CardItem card = controller.cardTypeList[index];
        switch (card.type) {
          case 'StatementCard':
            return StatementCardWidget(cardItem: card, pageIndex: index);
          case 'YesNoCard':
            return YesOrNoCardWidget(
              pageIndex: index,
              cardId: 'card_$index',
              cardItem: card,
            );
          case 'TextCard':
            return TextCardWidget(
              pageIndex: index,
              cardItem: card,
              cardId: 'card_$index',
            );
          case 'MultipleChoiceCard':
            return MultipleChoiceCardWidget(
              cardItem: card,
              pageIndex: index,
              cardId: 'card_$index',
            );
          default:
            return Container();
        }
      }),
      const FinishScreen()
    ];
  }
}
