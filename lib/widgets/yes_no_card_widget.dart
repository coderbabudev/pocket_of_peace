import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';

class YesOrNoCardWidget extends StatefulWidget {
  const YesOrNoCardWidget({
    super.key,
    this.title,
    this.subTitle,
    this.image,
  });

  final String? title;
  final String? subTitle;
  final String? image;

  @override
  State<YesOrNoCardWidget> createState() => _YesOrNoCardWidgetState();
}

class _YesOrNoCardWidgetState extends State<YesOrNoCardWidget> {
  bool yesSelect = false;
  bool noSelect = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? '',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlue,
              letterSpacing: 0.3),
        ).paddingOnly(top: 104, left: 30, right: 34),
        Center(
          child: Image.asset(
            widget.image ?? '',
            height: 85,
            width: 76,
            filterQuality: FilterQuality.high,
          ).paddingOnly(top: 29),
        ),
        Text(
          widget.subTitle ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.lightBlue,
          ),
        ).paddingOnly(top: 60, left: 30, right: 34),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    yesSelect = true;
                    noSelect = false;
                  });
                },
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.only(left: 17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFCED7D9).withOpacity(0.37),
                      border: Border.all(
                        color: yesSelect == true
                            ? const Color(0xFF000000)
                            : Colors.transparent,
                        width: 1,
                        style: BorderStyle.solid,
                      )),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.center,
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: yesSelect == true
                              ? const Color(0xFF5C5C5C)
                              : const Color(0xFFF5F9F9),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 0.3,
                            color: AppColors.lightBlue,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Y",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: yesSelect == true
                                  ? AppColors.primaryColor
                                  : AppColors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "  Yes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightBlue,
                          letterSpacing: 0.3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    noSelect = true;
                    yesSelect = false;
                  });
                },
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.only(left: 17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFCED7D9).withOpacity(0.37),
                      border: Border.all(
                        color: noSelect == true
                            ? const Color(0xFF000000)
                            : Colors.transparent,
                        width: 1,
                        style: BorderStyle.solid,
                      )),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.center,
                    children: [
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: noSelect == true
                              ? const Color(0xFF5C5C5C)
                              : const Color(0xFFF5F9F9),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              width: 0.3,
                              color: AppColors.lightBlue,
                              style: BorderStyle.solid),
                        ),
                        child: Center(
                          child: Text(
                            "N",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: noSelect == true
                                  ? AppColors.primaryColor
                                  : AppColors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "  No",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightBlue,
                          letterSpacing: 0.3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ).paddingOnly(top: 17, left: 30, right: 34)
      ],
    );
  }
}
