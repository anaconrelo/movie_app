import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/utils/colors.dart';
import 'package:movieapp/utils/dimension.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;

class CustomVideoPlayer extends StatefulWidget {
  //final VideoPlayerController videoPlayerController;
  final String videoUrl;
  final bool isLooping;
  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.isLooping,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  void _createChewieController() {
    _chewieController = ChewieController(
      maxScale: 10,
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoPlay: true,
      autoInitialize: true,
      looping: widget.isLooping,
      errorBuilder:
          (context, errorMessage) => Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          ),
    );
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    await Future.wait([_videoPlayerController.initialize()]);
    _createChewieController();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? Column(
          spacing: dimension.getHeight(25),
          children: [
            Container(
              width: double.infinity,
              height: dimension.screenHeight / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(dimension.getWidth(10)),
                border: Border.all(color: AppColors.poppy, width: 2),
                color: AppColors.engineeringOrange,
              ),
              child: Chewie(controller: _chewieController!),
            ),
            ElevatedButton(
              onPressed: () {
                html.document.documentElement?.requestFullscreen();
              },
              child: Text('Full Screen'),
            ),
          ],
        )
        : const Center(child: CircularProgressIndicator(color: Colors.white));
  }
}
