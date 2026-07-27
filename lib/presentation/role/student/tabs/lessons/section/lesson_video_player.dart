import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/resources/colors/color_manger.dart';

class LessonVideoPlayer extends StatefulWidget {
  const LessonVideoPlayer({
    super.key,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.onBack,
  });

  final String thumbnailUrl;
  final String videoUrl;
  final VoidCallback onBack;

  @override
  State<LessonVideoPlayer> createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends State<LessonVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isPlaying = false;
  bool _isLoading = false;

  Future<void> _startVideo() async {
    setState(() => _isLoading = true);

    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    await _videoController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
    );

    setState(() {
      _isPlaying = true;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_isPlaying && _chewieController != null)
            Chewie(controller: _chewieController!)
          else
            CachedNetworkImage(
              imageUrl: widget.thumbnailUrl,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => Container(color: Colors.black26),
            ),

          if (!_isPlaying)
            Positioned(
              top: 12,
              left: 12,
              child: InkWell(
                onTap: widget.onBack,
                child: const CircleAvatar(
                  backgroundColor: Colors.black38,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),

          if (!_isPlaying)
            Center(
              child: InkWell(
                onTap: _isLoading ? null : _startVideo,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: _isLoading
                      ? Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorManager.primary,
                          ),
                        )
                      : Icon(
                          Icons.play_arrow,
                          color: ColorManager.black,
                          size: 32,
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
