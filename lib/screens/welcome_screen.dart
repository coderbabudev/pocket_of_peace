import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/screens/show_card_screen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:pocket_of_peace/widgets/common_build_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  CardGroupController controller = Get.put(CardGroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.welcomeBg),
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Text(
              AppStrings.appName,
              style: TextStyle(
                color: AppColors.steelBlue,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: 0.3,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controller.currentMinValue.value != 0.0) {
                  controller.clearCardStateValue();
                  controller.loadJsonData().then((value) {
                    Get.to(
                      () => ShowCardScreen(
                        minuteValue: controller.currentMinValue.value,
                      ),
                    );
                  });
                } else {
                  showMessageSnackBar(
                    AppStrings.timerErrorText,
                    AppColors.steelBlue,
                  );
                }
              },
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    Assets.welcomeRoundBg,
                    height: 242,
                    width: 242,
                    filterQuality: FilterQuality.high,
                  ).paddingOnly(top: 105),
                  Positioned.fill(
                    top: 100,
                    left: -15,
                    child: Center(
                      child: Text(
                        AppStrings.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 60,
                          color: AppColors.lightBlue,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(() => SliderTheme(
                  data: SliderThemeData(
                    tickMarkShape: SliderTickMarkShape.noTickMark,
                  ),
                  child: Slider.adaptive(
                    min: 0.0,
                    divisions: 10,
                    max: 10.0,
                    value: controller.currentMinValue.value,
                    activeColor: AppColors.lightBlue,
                    inactiveColor: AppColors.offWhite.withOpacity(0.18),
                    thumbColor: AppColors.lightBlue,
                    onChanged: (value) {
                      setState(() {
                        controller.currentMinValue.value = value;
                      });
                    },
                  ).paddingOnly(top: 60, left: 17, right: 17),
                )),
            Obx(
              () => Text(
                "${controller.currentMinValue.toInt()} min",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: AppColors.lightBlue,
                  letterSpacing: 0.3,
                ),
              ),
            )
          ],
        ).paddingSymmetric(vertical: 20),
      ),
    );
  }
}
