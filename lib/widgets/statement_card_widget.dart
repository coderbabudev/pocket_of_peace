import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/model/card_group_model.dart';
import 'package:pocket_of_peace/model/quiz_data_model.dart';
import 'package:pocket_of_peace/screens/video_palyer_fullScreen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/widgets/animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class StatementCardWidget extends StatefulWidget {
  const StatementCardWidget({
    super.key,
    required this.cardItem,
    required this.pageIndex,
  });

  final CardItem cardItem;
  final int pageIndex;

  @override
  State<StatementCardWidget> createState() => _StatementCardWidgetState();
}

class _StatementCardWidgetState extends State<StatementCardWidget> {
  CardGroupController controller = Get.put(CardGroupController());
  VideoPlayerController? videoController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.cardItem.video != null) {
        videoController = VideoPlayerController.asset(
            'assets/videos/${widget.cardItem.video!}')
          ..initialize().then((_) {
            if (videoController!.value.hasError) {
              setState(() {
                _isLoading = false;
              });
              throw '${videoController!.value.errorDescription}';
            } else {
              setState(() {
                _isLoading = false;
                videoController!.setLooping(true);
                videoController!.play();
              });
            }
          }).catchError((error) {
            setState(() {
              _isLoading = false;
            });
            throw error;
          });
      }
      controller.quizDataList[widget.pageIndex] = CardDetail(
        id: widget.cardItem.idMain ?? 0,
        type: widget.cardItem.type,
        index: widget.cardItem.index,
        skillCategory: widget.cardItem.skillCategoryMain ?? '',
        subSkillCategory: widget.cardItem.subSkillCategoryMain ?? '',
      );
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
          if (widget.cardItem.title.isNotEmpty)
            Text(
              widget.cardItem.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3,
              ),
            ),
          if (widget.cardItem.image != null)
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: AnimationWidget(
                animationType: "FADE",
                child: Center(
                  child: Image.asset(
                    'assets/icons/${widget.cardItem.image}',
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
          if (widget.cardItem.video != null &&
              videoController != null &&
              videoController!.value.isInitialized)
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: AnimationWidget(
                animationType: "FADE",
                child: Center(
                  child: SizedBox(
                    height: 210,
                    width: 303,
                    child: _isLoading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.grey,
                            ),
                          )
                        : Stack(
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
              padding: EdgeInsets.only(
                top: (widget.cardItem.title.isEmpty ||
                        widget.cardItem.image == null ||
                        widget.cardItem.video == null)
                    ? 0
                    : 30,
              ),
              child: Text(
                widget.cardItem.subtitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlue,
                  letterSpacing: 0.3,
                ),
              ),
            ),
        ],
      ).paddingOnly(left: 37, right: 27),
    );
  }
}
