import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/screens/welcome_screen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:pocket_of_peace/widgets/exit_dialog_widget.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  CardGroupController controller = Get.put(CardGroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CardGroupController>(builder: (finishValue) {
      finishValue = controller;
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.mainBg),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: finishValue.isClose.value
            ? const Center(
                child: ExitDialogWidget(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   finishValue.isClose.value = true;
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
                  //   value: finishValue.progressValue,
                  //   borderRadius: BorderRadius.circular(10),
                  //   backgroundColor: AppColors.primaryColor,
                  //   minHeight: 10,
                  //   valueColor: AlwaysStoppedAnimation(AppColors.lightBlue),
                  //   color: AppColors.lightGreen,
                  // ).paddingOnly(left: 29, right: 25),
                  Column(
                    children: [
                      Text(
                        AppStrings.congratulations,
                        // AppStrings.placeholderFinish,
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
                        onTap: () => Get.offAll(() => const WelcomeScreen()),
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
                  )
                ],
              ).paddingSymmetric(vertical: 20),
      );
    }));
  }
}
