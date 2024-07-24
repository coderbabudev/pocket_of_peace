import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/screens/welcome_screen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:pocket_of_peace/widgets/common_placeholder_bg_widget.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlaceHolderBgWidget(
        child: Column(
          children: [
            Text(
              // AppStrings.congratulations,
              AppStrings.placeholderFinish,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: AppColors.lightBlue,
              ),
            ),
            // Image.asset(
            //   Assets.celebrateIcon,
            //   height: 125,
            //   width: 100,
            //   filterQuality: FilterQuality.high,
            // ).paddingSymmetric(vertical: 25),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Text(
            //     AppStrings.finishSubText,
            //     style: TextStyle(
            //       fontWeight: FontWeight.w400,
            //       fontSize: 18,
            //       color: AppColors.lightBlue,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 40),
            const SizedBox(height: 330),
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
        ),
      ),
    );
  }
}
