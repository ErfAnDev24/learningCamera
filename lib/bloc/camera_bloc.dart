import 'package:camera/camera.dart';
import 'package:erfancamera/bloc/camera_event.dart';
import 'package:erfancamera/bloc/camera_state.dart';
import 'package:erfancamera/utils/permission_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitialState()) {
    on<PrepareCameraEvent>((event, emit) async {
      PermissionChecker.checkCameraPermission();
      PermissionChecker.checkLocationPermission();

      emit(CameraLoadingState());

      List<CameraDescription> cameras = [];
      try {
        cameras = await availableCameras();
      } catch (e) {
        print(e);
      }

      var backCamera = cameras.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.front);

      CameraController controller = CameraController(
          backCamera, ResolutionPreset.medium,
          enableAudio: true);

      await controller.initialize();

      emit(PrepareCamaraState(controller));
    });

    on<ChangeCameraEvent>((event, emit) async {
      List<CameraDescription> cameras = [];
      try {
        cameras = await availableCameras();
      } catch (e) {
        print(e);
      }

      var cameraController = event.cameraController;

      var availableCamera;

      if (cameraController.description.lensDirection ==
          CameraLensDirection.front) {
        availableCamera = cameras.firstWhere(
            (element) => element.lensDirection == CameraLensDirection.back);

        cameraController = CameraController(
            availableCamera, ResolutionPreset.medium,
            enableAudio: true);
      } else if (cameraController.description.lensDirection ==
          CameraLensDirection.back) {
        availableCamera = cameras.firstWhere(
            (element) => element.lensDirection == CameraLensDirection.front);

        cameraController = CameraController(
            availableCamera, ResolutionPreset.medium,
            enableAudio: true);
      }
      await cameraController.initialize();

      print('ErfAn check ${cameraController.description.lensDirection}');
      emit(PrepareCamaraState(cameraController));
    });
  }
}
