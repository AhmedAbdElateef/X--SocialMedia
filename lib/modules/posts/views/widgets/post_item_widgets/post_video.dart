import 'dart:io';
//---------------
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//----------------------------------------------

class PostVideo extends StatefulWidget {
  final String? videoUrl;
  final File? videFile;

  const PostVideo({
    super.key,
    this.videFile,
    this.videoUrl,
  }) : assert(videoUrl != null || videFile != null);

  @override
  State<PostVideo> createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videFile != null) {
      _controller = VideoPlayerController.file(
        widget.videFile!,
        videoPlayerOptions: VideoPlayerOptions(),
      );
    } else {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl!),
        videoPlayerOptions: VideoPlayerOptions(),
      );
    }

    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Chewie(
              controller: ChewieController(
                videoPlayerController: _controller,
              ),
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
