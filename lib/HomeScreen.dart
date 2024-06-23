import 'package:camera/camera.dart';
import 'package:erfancamera/CameraScreen.dart';
import 'package:erfancamera/bloc/camera_bloc.dart';
import 'package:erfancamera/bloc/camera_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          child: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) {
                      var bloc = CameraBloc();
                      bloc.add(PrepareCameraEvent());
                      return bloc;
                    },
                    child: const CameraScreen(),
                  ),
                ),
              ),
              child: const Text('initialing camera'),
            ),
          ),
        ),
      ),
    );
  }
}
