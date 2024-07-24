import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';

class TextCardWidget extends StatefulWidget {
  const TextCardWidget({
    super.key,
    this.title,
    this.subTitle,
    this.maxLines = 1,
    this.numOfTextFields = 1,
  });

  final String? title;
  final String? subTitle;
  final int maxLines;
  final int numOfTextFields;

  @override
  State<TextCardWidget> createState() => _TextCardWidgetState();
}

class _TextCardWidgetState extends State<TextCardWidget> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _initializeTextControllers();
  }

  void _initializeTextControllers() {
    for (int i = 0; i < widget.numOfTextFields; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? 'Take a focused look at that place.',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlue,
              letterSpacing: 0.3),
        ).paddingOnly(top: 104, left: 34, right: 26),
        Text(
          widget.subTitle != null
              ? widget.subTitle.toString()
              : 'What’s one thing you noticed?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlue,
            letterSpacing: 0.3,
          ),
        ).paddingOnly(top: 24, left: 34, right: 47),
        ListView.builder(
          itemCount: _controllers.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return TextFormField(
              controller: _controllers[index],
              cursorColor: AppColors.lightBlue,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF5F8599),
                letterSpacing: 0.3,
              ),
              maxLines: widget.maxLines,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'ex: rustling leaves outside ',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xFF91B4BC),
                  letterSpacing: 0.3,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightBlue,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightBlue,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightBlue,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightBlue,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
              ),
            ).paddingOnly(left: 34, right: 41, top: index == 0 ? 20 : 10);
          },
        )
      ],
    );
  }
}
