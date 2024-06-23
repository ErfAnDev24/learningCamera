import 'package:camera/camera.dart';

class CameraEvent {}

class PrepareCameraEvent extends CameraEvent {}

class ChangeCameraEvent extends CameraEvent {
  final CameraController cameraController;
  ChangeCameraEvent({required this.cameraController});
}

class EnableFlashEvent extends CameraEvent {
  final CameraController cameraController;
  EnableFlashEvent({required this.cameraController});
}
