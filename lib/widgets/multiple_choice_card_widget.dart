import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';

class MultipleChoiceCardWidget extends StatefulWidget {
  const MultipleChoiceCardWidget({super.key, this.title});

  final String? title;

  @override
  State<MultipleChoiceCardWidget> createState() =>
      _MultipleChoiceCardWidgetState();
}

class _MultipleChoiceCardWidgetState extends State<MultipleChoiceCardWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title ?? 'Pick a place to focus on:',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlue,
            letterSpacing: 0.3,
          ),
        ).paddingOnly(top: 103, left: 23, right: 37),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 13,
            crossAxisSpacing: 19,
            mainAxisExtent: 140,
          ),
          padding: const EdgeInsets.only(left: 20, right: 39, top: 27),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                height: 134,
                width: 148,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: selectedIndex == index
                        ? const Color(0xFF000000)
                        : Colors.transparent,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  color: const Color(0xFFC2E3EB).withOpacity(0.37),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://cdn.pixabay.com/photo/2016/07/07/16/46/dice-1502706_640.jpg',
                      height: 83,
                      width: 117,
                    ).paddingOnly(
                      top: 9,
                      left: 15,
                      right: 16,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.center,
                      children: [
                        Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
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
                              String.fromCharCode(index + 65),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: selectedIndex == index
                                    ? AppColors.primaryColor
                                    : AppColors.lightBlue,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "  ceiling",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightBlue,
                            letterSpacing: 0.3,
                          ),
                        )
                      ],
                    ).paddingOnly(left: 14, bottom: 6)
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
