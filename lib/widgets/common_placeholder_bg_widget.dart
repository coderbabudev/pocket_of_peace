import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/screens/welcome_screen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';

class PlaceHolderBgWidget extends StatefulWidget {
  const PlaceHolderBgWidget({
    super.key,
    this.progressValue = 0.0,
    required this.child,
    this.valueColor,
  });

  final double progressValue;
  final Widget child;
  final Animation<Color?>? valueColor;

  @override
  State<PlaceHolderBgWidget> createState() => _PlaceHolderBgWidgetState();
}

class _PlaceHolderBgWidgetState extends State<PlaceHolderBgWidget> {
  CardGroupController controller = Get.put(CardGroupController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardGroupController>(builder: (closeValue) {
      closeValue = controller;
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
        child: closeValue.isClose.value
            ? Center(
                child: exitDialogWidget(controller),
              )
            : Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   closeValue.isClose.value = true;
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
                  //   value: widget.progressValue,
                  //   borderRadius: BorderRadius.circular(10),
                  //   backgroundColor: AppColors.primaryColor,
                  //   minHeight: 10,
                  //   valueColor: widget.valueColor,
                  //   color: AppColors.lightGreen,
                  // ).paddingOnly(left: 29, right: 25),
                  widget.child
                ],
              ).paddingSymmetric(vertical: 20),
      );
    });
  }

  Widget exitDialogWidget(CardGroupController controller) {
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
                    Get.offAll(() => const WelcomeScreen());
                    controller.isClose.value = false;
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
                  onTap: () {
                    setState(() {
                      controller.isClose.value = false;
                    });
                  },
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
  }
}
