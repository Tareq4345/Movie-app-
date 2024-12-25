import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController controller;
  Widget? controls;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        controller.play();
        controller.setVolume(1);
        setState(() {});
      })
      ..addListener(() {
        if (controller.value.isPlaying) {
          controls = GestureDetector(
              onTap: () {
                setState(() {
                  controller.pause();
                });
              },
              child: const Icon(Icons.pause));
        } else if (controller.value.position.inMilliseconds -
                controller.value.duration.inMilliseconds <
            1) {
          setState(() {
            controls = GestureDetector(
              onTap: () {
                setState(() {
                  controller.play();
                });
              },
              child: const Icon(Icons.play_circle),
            );
          });
        } else {
          controls = GestureDetector(
            onTap: () {
              setState(() {
                controller.play();
              });
            },
            child: const Icon(Icons.play_circle),
          );
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10.w, right: 10.w),
          width: double.infinity,
          height: 160,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: Colors.black,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: VideoPlayer(controller),
          ),
        ),
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controls ?? Container(),
            ],
          ),
        )
      ],
    );
  }
}
