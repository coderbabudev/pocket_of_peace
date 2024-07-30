import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/widgets/animation_widget.dart';
import 'package:pocket_of_peace/widgets/common_build_widget.dart';
import 'package:video_player/video_player.dart';

import '../screens/video_palyer_fullScreen.dart';

class MultipleChoiceCardWidget extends StatefulWidget {
  const MultipleChoiceCardWidget({
    super.key,
    this.title,
    required this.cardId,
    this.subTitle,
    this.hasImage = false,
    this.options,
    this.image,
    this.video,
    this.maxSelection,
  });

  final String cardId; // Unique card ID
  final String? title;
  final String? subTitle;
  final bool hasImage;
  final List<CardOption>? options;
  final String? image;
  final String? video;
  final int? maxSelection;

  @override
  State<MultipleChoiceCardWidget> createState() =>
      _MultipleChoiceCardWidgetState();
}

class _MultipleChoiceCardWidgetState extends State<MultipleChoiceCardWidget> {
  VideoPlayerController? videoController;
  CardGroupController controller = Get.put(CardGroupController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.video != null) {
        videoController =
            VideoPlayerController.asset('assets/videos/${widget.video!}')
              ..initialize().then((_) {
                setState(() {});
                videoController?.setLooping(true);
                videoController?.play();
              });
      }
    });
  }

  void _handleSelection(int index) async {
    int maxSelection = widget.maxSelection ?? 1;
    setState(() {
      final currentSelections =
          controller.getMultiChoiceCardState(widget.cardId);
      if (currentSelections.contains(index)) {
        controller.updateMultiChoiceCardState(
            widget.cardId, index, maxSelection);
      } else if (currentSelections.length < maxSelection) {
        controller.updateMultiChoiceCardState(
            widget.cardId, index, maxSelection);
        if (controller.getMultiChoiceCardState(widget.cardId).length >=
            maxSelection) {
          controller.pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      } else {
        showMessageSnackBar(
          'You can select up to $maxSelection options.',
          AppColors.steelBlue,
        );
      }
    });
  }

  void toggleFullScreen() {
    setState(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      Get.to(() => VideoPlayerFullscreenWidget(controller: videoController!));
    });
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 23,
                right: 37,
                bottom: 30,
              ),
              child: Text(
                widget.title!,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlue,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          if (widget.options!.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 19,
                mainAxisSpacing: 19,
                childAspectRatio: widget.hasImage ? 1.0 : 2.0,
              ),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 20, right: 39),
              itemCount: widget.options!.length,
              itemBuilder: (BuildContext context, int index) {
                final option = widget.options![index];
                final isSelected = controller
                    .getMultiChoiceCardState(widget.cardId)
                    .contains(index);
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GestureDetector(
                      onTap: () => _handleSelection(index),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF000000)
                                : Colors.transparent,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          color: const Color(0xFFC2E3EB).withOpacity(0.37),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.hasImage || option.image != null)
                              AnimationWidget(
                                animationType: 'FADE',
                                child: Image.asset(
                                  'assets/icons/${option.image}',
                                  height: 83,
                                  width: 117,
                                ).paddingOnly(top: 15, left: 15, right: 16),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 14,
                                bottom: 10,
                                right: 14,
                                top: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                      color: isSelected
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
                                          color: isSelected
                                              ? AppColors.primaryColor
                                              : AppColors.lightBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      option.text ?? 'Other',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.clip,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.lightBlue,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          if (widget.image != null)
            Padding(
              padding: const EdgeInsets.only(top: 25),
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
          if (widget.video != null &&
              videoController != null &&
              videoController!.value.isInitialized)
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: AnimationWidget(
                animationType: "FADE",
                child: Center(
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
                          GestureDetector(
                            onTap: () => toggleFullScreen(),
                            child: Icon(
                              Icons.fullscreen,
                              size: 35,
                              color: AppColors.primaryColor,
                            ).paddingOnly(bottom: 5, right: 5),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (widget.subTitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 23, right: 37),
              child: Text(
                widget.subTitle!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlue,
                  letterSpacing: 0.3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
