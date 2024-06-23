import 'dart:io';

import 'package:camera/camera.dart';
import 'package:erfancamera/PreviewScreen.dart';
import 'package:erfancamera/bloc/camera_bloc.dart';
import 'package:erfancamera/bloc/camera_event.dart';
import 'package:erfancamera/bloc/camera_state.dart';
import 'package:erfancamera/bloc/video_preview_bloc.dart';
import 'package:erfancamera/videoPreviewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 480,
          constraints: const BoxConstraints(
            maxWidth: 480,
            minWidth: 360,
          ),
          color: Colors.white,
          child: BlocBuilder<CameraBloc, CameraState>(
            builder: (context, state) {
              if (state is CameraInitialState) {
                return Text('data');
              }

              if (state is PrepareCamaraState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.camercontroller != null
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 350,
                                height: 480,
                                child: CameraPreview(state.camercontroller!),
                              ),
                              Positioned(
                                bottom: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: GestureDetector(
                                        onTap: () async {
                                          var file = await state.camercontroller
                                              ?.takePicture();
                                          var image = file?.path;
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PreviewScreen(
                                                      imageURL: image ?? ''),
                                            ),
                                          );
                                        },
                                        onLongPress: () async {
                                          // final erfan = join(
                                          //     (await getTemporaryDirectory())
                                          //         .path,
                                          //     '${DateTime.now()}.mp4');
                                          state.camercontroller
                                              ?.startVideoRecording();
                                        },
                                        onLongPressUp: () async {
                                          final file = await state
                                              .camercontroller
                                              ?.stopVideoRecording();

                                          var video = file?.path;

                                          VideoPlayerController controller =
                                              VideoPlayerController.file(
                                                  File(video ?? ''));

                                          await controller.initialize();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                create: (context) =>
                                                    VideoPreviewBloc(
                                                        controller),
                                                child:
                                                    const VideoPreviewScreen(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: const BoxDecoration(
                                              color: Colors.blueGrey,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: GestureDetector(
                                        onTap: () async {
                                          var camercontroller =
                                              await state.camercontroller;
                                          context.read<CameraBloc>().add(
                                              ChangeCameraEvent(
                                                  cameraController:
                                                      camercontroller!));
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: const BoxDecoration(
                                              color: Colors.pink,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Text('null'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        state.camercontroller?.dispose();
                      },
                      child: Text('back'),
                    ),
                  ],
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
