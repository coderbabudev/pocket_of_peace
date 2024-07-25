import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:pocket_of_peace/widgets/multiple_choice_card_widget.dart';
import 'package:pocket_of_peace/widgets/statement_card_widget.dart';
import 'package:pocket_of_peace/widgets/text_card_widget.dart';
import 'package:pocket_of_peace/widgets/yes_no_card_widget.dart';

import '../widgets/exit_dialog_widget.dart';
import 'finish_screen.dart';

class ShowCardScreen extends StatefulWidget {
  const ShowCardScreen({super.key});

  @override
  State<ShowCardScreen> createState() => _ShowCardScreenState();
}

class _ShowCardScreenState extends State<ShowCardScreen> {
  CardGroupController controller = Get.put(CardGroupController());

  @override
  void initState() {
    super.initState();
    controller.cardList.shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.pageController.page!.toInt() == 0) {
          controller.currentMinValue.value = 0.0;
          return true;
        } else {
          controller.pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return false; // Prevent exiting the screen
        }
      },
      child: Scaffold(
        body: GetBuilder<CardGroupController>(builder: (cardValue) {
          cardValue = controller;
          List<CardItem> flatCardList =
              cardValue.cardListSorted(cardValue.cardList);
          return Stack(
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
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage(Assets.mainBg),
                //     fit: BoxFit.cover,
                //     filterQuality: FilterQuality.high,
                //   ),
                // ),
                child: cardValue.isClose.value
                    ? const Center(
                        child: ExitDialogWidget(),
                      )
                    : Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   cardValue.isClose.value = true;
                                // });
                              },
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
                          // LinearProgressIndicator(
                          //   value: cardValue.progressValue,
                          //   borderRadius: BorderRadius.circular(10),
                          //   backgroundColor: AppColors.primaryColor,
                          //   minHeight: 10,
                          //   valueColor: AlwaysStoppedAnimation(AppColors.lightBlue),
                          //   color: AppColors.lightGreen,
                          // ).paddingOnly(left: 29, right: 25),
                          Expanded(
                            child: PageView.builder(
                              controller: cardValue.pageController,
                              itemCount: flatCardList.length,
                              itemBuilder: (context, groupIndex) {
                                CardItem card = flatCardList[groupIndex];
                                switch (card.type) {
                                  case 'MultipleChoiceCard':
                                    return MultipleChoiceCardWidget(
                                      title: card.title,
                                      subTitle: card.subtitle,
                                      image: card.image,
                                      video: card.video,
                                      hasImage: card.hasImages,
                                      options: card.options,
                                      maxSelection: card.selectionMax,
                                    );
                                  case 'TextCard':
                                    return TextCardWidget(
                                      title: card.title,
                                      subTitle: card.subtitle,
                                      image: card.image,
                                      video: card.video,
                                      numOfTextFields: card.numTextFields ?? 1,
                                      isExpandable: card.isExpandable!,
                                      placeholderTexts: card.placeholderTexts,
                                    );
                                  case 'YesNoCard':
                                    return YesOrNoCardWidget(
                                      title: card.title,
                                      subTitle: card.subtitle,
                                      image: card.image,
                                      video: card.video,
                                    );
                                  case 'StatementCard':
                                    return StatementCardWidget(
                                      image: card.image,
                                      title: card.title,
                                      subTitle: card.subtitle,
                                      video: card.video,
                                    );
                                  default:
                                    return Container();
                                }
                              },
                              physics: const BouncingScrollPhysics(),
                              onPageChanged: (index) {
                                setState(() {
                                  cardValue.progressValue =
                                      (index + 1) / flatCardList.length;
                                  if (index == flatCardList.length - 1) {
                                    Get.to(() => const FinishScreen());
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ).paddingSymmetric(vertical: 20),
              ),
            ],
          );
        }),
      ),
    );
  }
}
