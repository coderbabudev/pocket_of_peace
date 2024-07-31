import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/model/quiz_data_model.dart';
import 'package:pocket_of_peace/screens/video_palyer_fullScreen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:pocket_of_peace/widgets/animation_widget.dart';
import 'package:video_player/video_player.dart';

class YesOrNoCardWidget extends StatefulWidget {
  const YesOrNoCardWidget(
      {super.key,
      required this.pageIndex,
      required this.cardId,
      required this.cardItem});

  final String cardId;
  final int pageIndex;
  final CardItem cardItem;

  @override
  State<YesOrNoCardWidget> createState() => _YesOrNoCardWidgetState();
}

class _YesOrNoCardWidgetState extends State<YesOrNoCardWidget> {
  VideoPlayerController? videoController;
  CardGroupController controller = Get.put(CardGroupController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.cardItem.video != null) {
        videoController = VideoPlayerController.asset(
            'assets/videos/${widget.cardItem.video!}')
          ..initialize().then((_) {
            setState(() {});
            videoController?.setLooping(true);
            videoController?.play();
          });
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
    YesNOButtonStates cardState = controller.getYNButtonState(widget.cardId);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.cardItem.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 34),
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
          if (widget.cardItem.image != null)
            Padding(
              padding: const EdgeInsets.only(top: 29),
              child: Center(
                child: AnimationWidget(
                  animationType: "FADE",
                  child: Image.asset(
                    'assets/icons/${widget.cardItem.image!}',
                    height: 85,
                    width: 76,
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
          if (widget.cardItem.video != null &&
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
          if (widget.cardItem.subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 30, right: 34),
              child: Text(
                widget.cardItem.subtitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlue,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 17, left: 30, right: 34),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.updateYNButtonState(
                            widget.cardId, true, false);
                        controller.quizDataList[widget.pageIndex] = CardDetail(
                          id: widget.cardItem.idMain ?? 0,
                          type: widget.cardItem.type,
                          index: widget.cardItem.index,
                          skillCategory:
                              widget.cardItem.skillCategoryMain ?? '',
                          subSkillCategory:
                              widget.cardItem.subSkillCategoryMain ?? '',
                          yesNoAnswer: 'Yes',
                        );
                        controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeIn,
                        );
                      });
                    },
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.only(left: 17),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFCED7D9).withOpacity(0.37),
                          border: Border.all(
                            color: cardState.isYesSelected
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
                              color: cardState.isYesSelected
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
                                AppStrings.y,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: cardState.isYesSelected
                                      ? AppColors.primaryColor
                                      : AppColors.lightBlue,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "  ${AppStrings.yes}",
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
                        controller.updateYNButtonState(
                            widget.cardId, false, true);
                        controller.quizDataList[widget.pageIndex] = CardDetail(
                          id: widget.cardItem.idMain ?? 0,
                          type: widget.cardItem.type,
                          index: widget.cardItem.index,
                          skillCategory:
                              widget.cardItem.skillCategoryMain ?? '',
                          subSkillCategory:
                              widget.cardItem.subSkillCategoryMain ?? '',
                          yesNoAnswer: 'No',
                        );
                        controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeIn,
                        );
                      });
                    },
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.only(left: 17),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFCED7D9).withOpacity(0.37),
                          border: Border.all(
                            color: cardState.isNoSelected
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
                              color: cardState.isNoSelected
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
                                AppStrings.n,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: cardState.isNoSelected
                                      ? AppColors.primaryColor
                                      : AppColors.lightBlue,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "  ${AppStrings.no}",
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
            ),
          )
        ],
      ),
    );
  }
}
