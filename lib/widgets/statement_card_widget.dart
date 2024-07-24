import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';

class StatementCardWidget extends StatefulWidget {
  const StatementCardWidget({
    super.key,
    this.title,
    this.subTitle,
    this.image,
  });

  final String? title;
  final String? subTitle;
  final String? image;

  @override
  State<StatementCardWidget> createState() => _StatementCardWidgetState();
}

class _StatementCardWidgetState extends State<StatementCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? 'Now we\'ll do a quick check-in with our feet!',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlue,
            letterSpacing: 0.3,
          ),
        ).paddingOnly(top: 108),
        Center(
          child: Image.asset(
            widget.image != null ? widget.image! : 'assets/icons/5801.png',
            height: 102,
            width: 108,
            filterQuality: FilterQuality.high,
          ),
        ).paddingOnly(top: 53, bottom: 30),
        Text(
          widget.subTitle != null
              ? widget.subTitle!
              : 'Our feet hold so much tension, but we rarely pay them much attention.',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.lightBlue,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ).paddingOnly(left: 39,right: 27);
  }
}
