
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../data/model/lesson_progress.dart';
import '../../view_model/lesson_progress_view_model.dart';


class LessonVideoPlayer extends StatefulWidget {
  const LessonVideoPlayer({
    super.key,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.onBack,
    required this.lessonId,
    required this.studentId,
  });

  final String thumbnailUrl;
  final String videoUrl;
  final String lessonId;
  final String studentId;
  final VoidCallback onBack;

  @override
  State<LessonVideoPlayer> createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends State<LessonVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isPlaying = false;
  bool _isLoading = false;
  LessonProgressModel? _lessonProgress;

  int _lastSavedProgress = 0;

  Future<void> _startVideo() async {
    setState(() => _isLoading = true);

    try {
      final progressCubit = context.read<LessonProgressCubit>();

      final existingProgress = await context
          .read<LessonProgressCubit>()
          .getProgress(widget.lessonId, widget.studentId);
      _lessonProgress = existingProgress;

      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await _videoController!.initialize();

      if (existingProgress != null && existingProgress.progress > 0) {
        final duration = _videoController!.value.duration;

        final position = Duration(
          milliseconds:
              (duration.inMilliseconds * existingProgress.progress / 100)
                  .round(),
        );

        await _videoController!.seekTo(position);

        _lastSavedProgress = existingProgress.progress;
      } else {
        _lessonProgress = LessonProgressModel(
          lessonId: widget.lessonId,
          studentId: widget.studentId,
          progress: 0,
        );


        await progressCubit.createLessonProgress(_lessonProgress!);
      }

      _videoController!.addListener(_onVideoProgress);

      _chewieController = ChewieController(
        materialProgressColors: ChewieProgressColors(
          playedColor: ColorManager.primary,
          handleColor: ColorManager.primary,
          backgroundColor: ColorManager.white,
        ),
        cupertinoProgressColors: ChewieProgressColors(
          playedColor: ColorManager.primary,
          handleColor: ColorManager.primary,
          backgroundColor: ColorManager.white,
        ),
        allowFullScreen: true,
        allowMuting: true,
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
      );

      if (mounted) {
        setState(() {
          _isPlaying = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _videoController?.removeListener(_onVideoProgress);
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 9,
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
              child: GestureDetector(
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
              child: GestureDetector(
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

  void _onVideoProgress() {
    final controller = _videoController;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    final position = controller.value.position;
    final duration = controller.value.duration;

    if (duration.inMilliseconds <= 0) {
      return;
    }

    final progress = (position.inMilliseconds / duration.inMilliseconds) * 100;

    final roundedProgress = progress.clamp(0, 100).round();

    if (roundedProgress - _lastSavedProgress >= 5) {
      _saveProgress(roundedProgress);
    }

    if (position >= duration) {
      _saveProgress(100);
    }
  }

  Future<void> _saveProgress(int progress) async {
    if (_lessonProgress == null) {
      return;
    }

    if (progress <= _lastSavedProgress) {
      return;
    }

    final updatedProgress = _lessonProgress!.copyWith(progress: progress);

    _lessonProgress = updatedProgress;
    _lastSavedProgress = progress;

    if (!mounted) {
      return;
    }

    await context.read<LessonProgressCubit>().updateLessonProgress(
      updatedProgress,
    );
  }
}
