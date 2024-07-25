import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/utils/string_utils.dart';
import 'package:video_player/video_player.dart';

class YesOrNoCardWidget extends StatefulWidget {
  const YesOrNoCardWidget({
    super.key,
    this.title,
    this.subTitle,
    this.image,
    this.video,
    this.valueColor,
    this.progressValue = 0,
  });

  final String? title;
  final String? subTitle;
  final String? image;
  final String? video;
  final double progressValue;
  final Animation<Color?>? valueColor;

  @override
  State<YesOrNoCardWidget> createState() => _YesOrNoCardWidgetState();
}

class _YesOrNoCardWidgetState extends State<YesOrNoCardWidget> {
  bool yesSelect = false;
  bool noSelect = false;
  late VideoPlayerController _controller;
  CardGroupController controller = Get.put(CardGroupController());

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
    }
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
          Text(
            widget.title ?? '',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3),
          ).paddingOnly(top: 104, left: 30, right: 34),
          Center(
            child: widget.image != null
                ? Image.asset(
                    '${Assets.assetsPath}${widget.image!}',
                    height: 85,
                    width: 76,
                    filterQuality: FilterQuality.high,
                  ).paddingOnly(top: 29)
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
                          ).paddingOnly(top: 29)
                        : Container()
                    : const SizedBox(),
          ),
          Text(
            widget.subTitle ?? '',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlue,
            ),
          ).paddingOnly(top: 60, left: 30, right: 34),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      yesSelect = true;
                      noSelect = false;
                      controller.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
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
                          color: yesSelect == true
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
                            color: yesSelect == true
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
                              "Y",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: yesSelect == true
                                    ? AppColors.primaryColor
                                    : AppColors.lightBlue,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "  Yes",
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
                      noSelect = true;
                      yesSelect = false;
                      controller.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
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
                          color: noSelect == true
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
                            color: noSelect == true
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
                              "N",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: noSelect == true
                                    ? AppColors.primaryColor
                                    : AppColors.lightBlue,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "  No",
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
          ).paddingOnly(top: 17, left: 30, right: 34)
        ],
      ),
    );
  }
}
