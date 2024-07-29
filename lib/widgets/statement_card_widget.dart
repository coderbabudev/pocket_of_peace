import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocket_of_peace/controller/card_group_controller.dart';
import 'package:pocket_of_peace/screens/video_palyer_fullScreen.dart';
import 'package:pocket_of_peace/utils/color_utils.dart';
import 'package:pocket_of_peace/widgets/animation_widget.dart';
import 'package:shimmer/shimmer.dart';
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

class _StatementCardWidgetState extends State<StatementCardWidget> {
  CardGroupController controller = Get.put(CardGroupController());
  VideoPlayerController? videoController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.video != null) {
        videoController =
            VideoPlayerController.asset('assets/videos/${widget.video!}')
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
            Text(
              widget.title!,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlue,
                letterSpacing: 0.3,
              ),
            ),
          if (widget.image != null)
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: AnimationWidget(
                animationType: "FADE",
                child: Center(
                  child: Image.asset(
                    'assets/icons/${widget.image}',
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
          if (widget.subTitle != null)
            Padding(
              padding: EdgeInsets.only(
                top: (widget.image == null ||
                        widget.title == null ||
                        widget.video == null)
                    ? 0
                    : 30,
              ),
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
      ).paddingOnly(left: 37, right: 27),
    );
  }
}
