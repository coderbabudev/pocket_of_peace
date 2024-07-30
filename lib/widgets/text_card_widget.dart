import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/widgets/animation_widget.dart';

class TextCardWidget extends StatefulWidget {
  const TextCardWidget({
    super.key,
    required this.cardId,
    this.title,
    this.subTitle,
    this.numOfTextFields = 1,
    this.placeholderTexts,
    this.image,
    this.isExpandable = false,
  });

  final String cardId;
  final String? title;
  final String? subTitle;
  final int numOfTextFields;
  final List<String>? placeholderTexts;
  final String? image;
  final bool isExpandable;

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
      if (widget.placeholderTexts != null) {
        for (int i = 0; i < widget.placeholderTexts!.length; i++) {
          hintTextList.add(widget.placeholderTexts![i]);
        }
      }
    });
  }

  void _initializeTextControllers() {
    setState(() {
      for (int i = 0; i < widget.numOfTextFields; i++) {
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
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(left: 34, right: 26),
            child: Text(
              widget.title!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3,
              ),
            ),
          ),
        if (widget.subTitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 34, right: 47),
            child: Text(
              widget.subTitle ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3,
              ),
            ),
          ),
        if (widget.image != null)
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: AnimationWidget(
                animationType: "FADE",
                child: Image.asset(
                  'assets/icons/${widget.image!}',
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
                maxLines: widget.isExpandable ? null : 1,
                minLines: widget.isExpandable ? 1 : 1,
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
