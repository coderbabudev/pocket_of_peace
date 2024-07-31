import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/screens/welcome_screen.dart';
import 'package:pocket_of_peace/services/firebase_services.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  CardGroupController controller =
      Get.put<CardGroupController>(CardGroupController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.congratulations,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: AppColors.lightBlue,
          ),
        ).paddingOnly(top: 51),
        Image.asset(
          Assets.celebrateIcon,
          height: 125,
          width: 100,
          filterQuality: FilterQuality.high,
        ).paddingSymmetric(vertical: 25),
        Text(
          AppStrings.finishSubText,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: AppColors.lightBlue,
          ),
        ).paddingOnly(left: 51, right: 33),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            setState(() {
              FirebaseServices().saveQuizData(controller.quizDataList);
              controller.currentMinValue.value = 0.0;
              controller.progressValue.value = 0.0;
              Get.offAll(() => const WelcomeScreen());
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                Assets.finishBtn,
                height: 56,
                width: 173,
                filterQuality: FilterQuality.high,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  AppStrings.finish,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColors.primaryColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
