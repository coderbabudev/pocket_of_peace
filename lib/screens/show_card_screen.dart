import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/screens/finish_screen.dart';
import 'package:pocket_of_peace/widgets/common_placeholder_bg_widget.dart';

class ShowCardScreen extends StatefulWidget {
  const ShowCardScreen({super.key});

  @override
  State<ShowCardScreen> createState() => _ShowCardScreenState();
}

class _ShowCardScreenState extends State<ShowCardScreen> {
  CardGroupController controller = Get.put(CardGroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CardGroupController>(builder: (cardValue) {
        cardValue = controller;
        // return const PlaceHolderBgWidget(child: StatementCardWidget());
        return PlaceHolderBgWidget(
          child: Expanded(
            child: PageView.builder(
              controller: cardValue.pageController,
              itemCount: cardValue.cardList.length,
              itemBuilder: (context, index) {
                final cardDetails = cardValue.cardList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("id : ${cardDetails['id']}"),
                    ...List.generate(
                      cardDetails['card_list'].length,
                      (cardIndex) => Text(
                          "index : ${cardDetails['card_list'][cardIndex]['index']}"),
                    ),
                    // Expanded(
                    //   child: PageView.builder(
                    //       controller: cardValue.pageController,
                    //       itemCount: cardDetails['card_list'].length,
                    //       itemBuilder: (context, cardIndex) {
                    //         return Text(
                    //             "index : ${cardDetails['card_list'][cardIndex]['index']}");
                    //       }),
                    // )
                  ],
                ).paddingOnly(left: 23, top: 50);
              },
              onPageChanged: (index) {
                if (index == cardValue.cardList.length - 1) {
                  Get.to(() => const FinishScreen());
                  setState(() {});
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
