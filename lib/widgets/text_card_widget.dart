import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/widgets/animation_widget.dart';
import 'package:video_player/video_player.dart';

class TextCardWidget extends StatefulWidget {
  const TextCardWidget({
    super.key,
    this.title,
    this.subTitle,
    this.numOfTextFields = 1,
    this.placeholderTexts,
    this.image,
    this.isExpandable = false,
    this.video,
  });

  final String? title;
  final String? subTitle;
  final int numOfTextFields;
  final List<String>? placeholderTexts;
  final String? image;
  final String? video;
  final bool isExpandable;

  @override
  State<TextCardWidget> createState() => _TextCardWidgetState();
}

class _TextCardWidgetState extends State<TextCardWidget> {
  final List<TextEditingController> _controllers = [];
  final List<String> hintTextList = [];
  final List<String> textValues = [];
  VideoPlayerController? videoController;
  CardGroupController controller = Get.put(CardGroupController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initializeTextControllers();
      for (int i = 0; i < widget.placeholderTexts!.length; i++) {
        hintTextList.add(widget.placeholderTexts![i].toString());
      }
      if (widget.video != null) {
        videoController =
            VideoPlayerController.asset('assets/videos/${widget.video!}')
              ..initialize().then((_) {
                setState(() {});
              });
        videoController?.setLooping(true);
        videoController?.play();
      }
    });
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
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3),
          ).paddingOnly(top: 104, left: 34, right: 26),
        if (widget.subTitle != null)
          Text(
            widget.subTitle!,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlue,
              letterSpacing: 0.3,
            ),
          ).paddingOnly(top: 24, left: 34, right: 47),
        if (widget.image != null)
          Center(
              child: AnimationWidget(
            animationType: "FADE",
            child: Image.asset(
              'assets/icons/${widget.image!}',
              height: 102,
              width: 108,
              filterQuality: FilterQuality.high,
            ),
          ).paddingOnly(top: 25, bottom: 30)),
        if (widget.video != null &&
            videoController != null &&
            videoController!.value.isInitialized)
          Center(
            child: AnimationWidget(
              animationType: "FADE",
              child: SizedBox(
                height: 210,
                width: 303,
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.isClick.value =
                                !controller.isClick.value;
                          });
                        },
                        child: VideoPlayer(videoController!)),
                    if (controller.isClick.value)
                      const Icon(
                        Icons.fullscreen,
                        size: 35,
                        color: Color(0xFF000000),
                      ).paddingOnly(bottom: 5, right: 5)
                  ],
                ),
              ),
            ),
          ).paddingOnly(top: 25, bottom: 30),
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
            ).paddingOnly(left: 34, right: 41, top: index == 0 ? 20 : 10);
          },
        )
      ],
    );
  }
}
