import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ImageDetectionPage extends StatefulWidget {
  const ImageDetectionPage({super.key});

  @override
  ImageDetectionPageState createState() => ImageDetectionPageState();
}

class ImageDetectionPageState extends State<ImageDetectionPage> {
  late ARKitController arkitController;
  Timer? timer;
  bool anchorWasFound = false;
  String? referenceImageName;

  static String mars =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/800px-OSIRIS_Mars_true_color.jpg';
  static String earth =
      'https://upload.wikimedia.org/wikipedia/commons/c/cb/The_Blue_Marble_%28remastered%29.jpg';
  static String bee =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  static String butterfly =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

  @override
  void dispose() {
    timer?.cancel();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Image Detection Sample')),
        body: Stack(
          fit: StackFit.expand,
          children: [
            ARKitSceneView(
              detectionImages: [
                ARKitReferenceImage(
                  name: mars,
                  physicalWidth: 0.2,
                ),
                ARKitReferenceImage(
                  name: earth,
                  physicalWidth: 0.8,
                )
              ],
              // detectionImagesGroupName: 'AR Marker',
              onARKitViewCreated: onARKitViewCreated,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                !anchorWasFound
                    ? 'Point the camera at the image from the article about Mars on Wikipedia.'
                    : 'Found: $referenceImageName',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      setState(() => anchorWasFound = true);

      referenceImageName = anchor.referenceImageName;

      final video = ARKitMaterialProperty.video(
        url: anchor.referenceImageName == mars ? bee : butterfly,
        width: 640,
        height: 320,
        autoplay: true,
      );

      final material = ARKitMaterial(
        diffuse: video,
        doubleSided: true,
      );

      final plane = ARKitPlane(
        width: 0.5,
        height: 0.3,
        materials: [material],
      );

      final earthPosition = anchor.transform.getColumn(3);
      final node = ARKitNode(
        geometry: plane,
        position:
            vector.Vector3(earthPosition.x, earthPosition.y, earthPosition.z),
        eulerAngles: vector.Vector3(0, 0, 0),
      );
      arkitController.add(node);
    }
  }
}
