import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/screens/finish_screen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:pocket_of_peace/widgets/exit_dialog_widget.dart';
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
    int n = widget.minuteValue.toInt();
    controller.initializeMandatoryCategories(n);
    controller.cardTypeList = controller.selectedCardGroups
        .expand((group) => group.cardList)
        .toList();
    controller.card = [];
    controller.card.addAll(data(controller.cardTypeList));
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
                          : const ScrollPhysics(),
                      itemBuilder: (context, groupIndex) {
                        return controller.card[groupIndex];
                      },
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) {
                        controller.currentPage.value = index;
                        setState(() {
                          controller.progressValue.value =
                              (index + 1) / controller.card.length;
                        });
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
          case 'MultipleChoiceCard':
            return MultipleChoiceCardWidget(
              title: card.title,
              subTitle: card.subtitle,
              image: card.image,
              video: card.video,
              hasImage: card.hasImages,
              options: card.options,
              maxSelection: card.selectionMax,
              cardId: 'card_$index',
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
              cardId: 'card_$index',
            );
          case 'YesNoCard':
            return YesOrNoCardWidget(
              title: card.title,
              subTitle: card.subtitle,
              image: card.image,
              video: card.video,
              id: 'card_$index',
            );
          case 'StatementCard':
            return StatementCardWidget(
              image: card.image ?? '',
              title: card.title,
              subTitle: card.subtitle,
              video: card.video,
            );
          default:
            return Container();
        }
      }),
      const FinishScreen()
    ];
  }
}
