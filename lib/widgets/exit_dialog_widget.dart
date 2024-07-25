import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/screens/welcome_screen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';

class ExitDialogWidget extends StatefulWidget {
  const ExitDialogWidget({super.key});

  @override
  State<ExitDialogWidget> createState() => _ExitDialogWidgetState();
}

class _ExitDialogWidgetState extends State<ExitDialogWidget> {
  CardGroupController controller = Get.put(CardGroupController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardGroupController>(builder: (exitValue) {
      exitValue = controller;
      return Container(
        height: 259,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: AppColors.borderColor,
            style: BorderStyle.solid,
          ),
          gradient: LinearGradient(colors: [
            const Color(0xFFFBBE8B).withOpacity(0.3),
            const Color(0xFFFFFFFF),
          ], begin: Alignment.topCenter, end: Alignment.center),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.exitText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlue,
              ),
            ).paddingOnly(top: 31, left: 27, right: 27),
            Text(
              AppStrings.exitSubText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlue,
              ),
            ).paddingOnly(top: 20, left: 27, right: 27),
            Divider(
              color: AppColors.borderColor,
              thickness: 1,
            ).paddingOnly(top: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      exitValue.isClose.value = false;
                      Get.offAll(() => const WelcomeScreen());
                    },
                    child: Container(
                      height: 57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFC2E3EB).withOpacity(0.24),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.yes,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: AppColors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: GestureDetector(
                    // onTap: () => exitValue.closeExitDialog(),
                    child: Container(
                      height: 57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFFBBE8B).withOpacity(0.24),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.no,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: AppColors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ).paddingOnly(left: 22, right: 22, top: 3)
          ],
        ),
      );
    });
  }
}
