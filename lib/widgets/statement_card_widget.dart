import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:video_player/video_player.dart';

class StatementCardWidget extends StatefulWidget {
  const StatementCardWidget({
    super.key,
    this.title,
    this.subTitle,
    this.image,
    this.video,
    this.progressValue = 0.0,
    this.valueColor,
  });

  final String? title;
  final String? subTitle;
  final String? image;
  final String? video;
  final double progressValue;
  final Animation<Color?>? valueColor;

  @override
  State<StatementCardWidget> createState() => _StatementCardWidgetState();
}

class _StatementCardWidgetState extends State<StatementCardWidget> {
  CardGroupController controller = Get.put(CardGroupController());
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.video != null) {
      _controller =
          VideoPlayerController.asset('${Assets.videoPath}${widget.video!}')
            ..initialize().then((_) {
              setState(() {});
              _controller.setLooping(true);
              _controller.play();
            });
    } else {}
  }

  @override
  void dispose() {
    _controller.dispose();
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
          Center(
            child: widget.image != null
                ? Image.asset(
                    '${Assets.assetsPath}${widget.image!}',
                    height: 102,
                    width: 108,
                    filterQuality: FilterQuality.high,
                  )
                : widget.video != null
                    ? _controller.value.isInitialized
                        ? SizedBox(
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
                                    child: VideoPlayer(_controller)),
                                if (controller.isClick.value)
                                  const Icon(
                                    Icons.fullscreen,
                                    size: 35,
                                    color: Color(0xFF000000),
                                  ).paddingOnly(bottom: 5, right: 5)
                              ],
                            ),
                          )
                        : Container()
                    : const SizedBox(),
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
