import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PreviewScreen extends StatelessWidget {
  final String imageURL;
  const PreviewScreen({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('image result'),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: Image.file(
              File(imageURL),
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
      ),
    ));
  }
}
