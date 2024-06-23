import 'dart:io';

import 'package:erfancamera/bloc/video_preview_bloc.dart';
import 'package:erfancamera/bloc/video_preview_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatelessWidget {
  const VideoPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('video result'),
          const SizedBox(
            height: 40,
          ),
          BlocBuilder<VideoPreviewBloc, VideoPreviewState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: state.controller.value.isInitialized
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: state.controller.value.aspectRatio,
                                child: VideoPlayer(state.controller),
                              ),
                              GestureDetector(
                                onTap: () {
                                  state.controller.value.isPlaying
                                      ? state.controller.pause()
                                      : state.controller.play();
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  Container(
                    width: 300,
                    height: 30, // افزایش ارتفاع برای در نظر گرفتن پدینگ
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: VideoProgressIndicator(
                          state.controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            backgroundColor: Colors.blueGrey,
                            playedColor: Colors.pink,
                            bufferedColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('back'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ));
  }
}
