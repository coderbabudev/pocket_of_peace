import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:video_player/video_player.dart';

class StatementCardWidget extends StatefulWidget {
  const StatementCardWidget({
    super.key,
    this.title,
    this.subTitle,
    this.image,
    this.video,
  });

  final String? title;
  final String? subTitle;
  final String? image;
  final String? video;

  @override
  State<StatementCardWidget> createState() => _StatementCardWidgetState();
}

class _StatementCardWidgetState extends State<StatementCardWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  CardGroupController controller = Get.put(CardGroupController());
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("widget.image.path : ${widget.image}");
      if (widget.video != null) {
        print("widget.video.path : ${widget.video}");
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
            Text(
              widget.title!,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3,
              ),
            ).paddingOnly(top: 108),
          if (widget.image != null)
            Center(
              child: Image.asset(
                'assets/icons/${widget.image!}',
                height: 102,
                width: 108,
                filterQuality: FilterQuality.high,
              ),
            ).paddingOnly(top: 25, bottom: 30),
          if (widget.video != null &&
              videoController != null &&
              videoController!.value.isInitialized)
            Center(
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
            ).paddingOnly(top: 25, bottom: 30),
          if (widget.subTitle != null)
            Text(
              widget.subTitle!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlue,
                letterSpacing: 0.3,
              ),
            ),
        ],
      ).paddingOnly(left: 37, right: 27),
    );
  }
}
