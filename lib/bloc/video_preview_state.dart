import 'package:video_player/video_player.dart';

class VideoPreviewState {
  final VideoPlayerController controller;
  VideoPreviewState({required this.controller});
}

class VideoPreviewInitialState extends VideoPreviewState {
  VideoPreviewInitialState(controller) : super(controller: controller);
}
