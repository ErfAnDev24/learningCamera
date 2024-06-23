import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class CameraState extends Equatable {
  CameraController? camercontroller;
  CameraState({this.camercontroller});

  @override
  List<Object?> get props => [camercontroller];
}

class CameraInitialState extends CameraState {
  CameraInitialState();
}

class CameraLoadingState extends CameraState {
  CameraLoadingState();
}

class PrepareCamaraState extends CameraState {
  PrepareCamaraState(camercontroller) : super(camercontroller: camercontroller);
}

class FlipCameraState extends CameraState {
  FlipCameraState(camercontroller) : super(camercontroller: camercontroller);
}
