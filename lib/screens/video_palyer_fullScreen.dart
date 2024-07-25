// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerFullscreenWidget extends StatefulWidget {
//   const VideoPlayerFullscreenWidget({
//     super.key,
//     required this.controller,
//   });
//
//   final VideoPlayerController controller;
//
//   @override
//   State<VideoPlayerFullscreenWidget> createState() =>
//       _VideoPlayerFullscreenWidgetState();
// }
//
// class _VideoPlayerFullscreenWidgetState
//     extends State<VideoPlayerFullscreenWidget> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) =>
//       widget.controller != null && widget.controller.value.isInitialized
//           ? Container(alignment: Alignment.topCenter, child: buildVideo())
//           : const Center(child: CircularProgressIndicator());
//
//   Widget buildVideo() => Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           buildFullScreen(
//             child: AspectRatio(
//               aspectRatio: widget.controller.value.aspectRatio,
//               child: VideoPlayer(widget.controller),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0, bottom: 5),
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: const Icon(
//                   Icons.fullscreen_exit,
//                   size: 35,
//                   color: Color(0xFF000000),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//
//   Widget buildFullScreen({
//     required Widget child,
//   }) {
//     final size = widget.controller.value.size;
//     final width = size.width;
//     final height = size.height;
//
//     return FittedBox(
//       fit: BoxFit.cover,
//       child: SizedBox(width: width, height: height, child: child),
//     );
//   }
// }
