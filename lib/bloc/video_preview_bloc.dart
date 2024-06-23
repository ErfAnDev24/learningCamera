import 'package:erfancamera/bloc/video_preview_event.dart';
import 'package:erfancamera/bloc/video_preview_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewBloc extends Bloc<VideoPreviewEvent, VideoPreviewState> {
  VideoPreviewBloc(VideoPlayerController videoPlayerController)
      : super(VideoPreviewInitialState(videoPlayerController));
}
