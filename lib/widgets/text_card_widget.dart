import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/widgets/animation_widget.dart';

import '../model/quiz_data_model.dart';

class TextCardWidget extends StatefulWidget {
  const TextCardWidget({
    super.key,
    required this.cardId,
    required this.pageIndex,
    required this.cardItem,
  });

  final String cardId;
  final int pageIndex;
  final CardItem cardItem;

  @override
  State<TextCardWidget> createState() => _TextCardWidgetState();
}

class _TextCardWidgetState extends State<TextCardWidget> {
  final List<TextEditingController> _controllers = [];
  final List<String> hintTextList = [];
  final List<String> textValues = [];

  CardGroupController controller = Get.put(CardGroupController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initializeTextControllers();
      if (widget.cardItem.placeholderTexts != null) {
        for (int i = 0; i < widget.cardItem.placeholderTexts!.length; i++) {
          hintTextList.add(widget.cardItem.placeholderTexts![i]);
        }
      }
    });
  }

  void _initializeTextControllers() {
    setState(() {
      for (int i = 0; i < widget.cardItem.numTextFields!; i++) {
        final textEditingController = TextEditingController(
          text: controller.getTextFieldStates(widget.cardId, i),
        );
        textEditingController.addListener(() {
          controller.updateTextFieldStates(
            widget.cardId,
            i,
            textEditingController.text,
          );
        });
        _controllers.add(textEditingController);
      }
    });
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
    return ListView(
      shrinkWrap: true,
      children: [
        if (widget.cardItem.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 34, right: 26),
            child: Text(
              widget.cardItem.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3,
              ),
            ),
          ),
        if (widget.cardItem.subtitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 34, right: 47),
            child: Text(
              widget.cardItem.subtitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3,
              ),
            ),
          ),
        if (widget.cardItem.image != null)
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: AnimationWidget(
                animationType: "FADE",
                child: Image.asset(
                  'assets/icons/${widget.cardItem.image!}',
                  height: 102,
                  width: 108,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 0,
                      width: 0,
                    );
                  },
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 34, right: 41, top: 30),
          child: ListView.builder(
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
                onChanged: (value) {
                  controller.quizDataList[widget.pageIndex] = CardDetail(
                      id: widget.cardItem.idMain ?? 0,
                      type: widget.cardItem.type,
                      index: widget.cardItem.index,
                      skillCategory: widget.cardItem.skillCategoryMain ?? '',
                      subSkillCategory:
                          widget.cardItem.subSkillCategoryMain ?? '',
                      textValue: [_controllers[index].text]);
                },
                maxLines: widget.cardItem.isExpandable ?? false ? null : 1,
                minLines: widget.cardItem.isExpandable ?? false ? 1 : 1,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: hintTextList[index],
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
              );
            },
          ),
        )
      ],
    );
  }
}
