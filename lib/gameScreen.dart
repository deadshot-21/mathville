import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:mathville/constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.answer});
  final String answer;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late UnityWidgetController unityWidgetController;

  void onUnityCreated(controller) {
    if (!mounted) return;
    setState(() {
      unityWidgetController = controller;
    });
    Duration delayDuration =
        Duration(seconds: (isFirstTime!) ? 8 : 0); // 2 seconds delay
    Future.delayed(delayDuration, () {
      isFirstTime = false;
      unityWidgetController.postMessage(
        'NumberController',
        'SetNumber',
        widget.answer,
      );
    });
  }

  void onPressed() {
    if (!mounted) return;
    setState(() {});
    unityWidgetController.postMessage(
      'NumberController',
      'SetNumber',
      widget.answer,
    );
  }

  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    // Duration delayDuration = const Duration(seconds: 10); // 2 seconds delay
    // Future.delayed(delayDuration, () {
    //   unityWidgetController.postMessage(
    //     'NumberController',
    //     'SetNumber',
    //     '7',
    //   );
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    unityWidgetController.pause();
  }

// add onwillpopscope
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: UnityWidget(
        onUnityCreated: onUnityCreated,
        onUnitySceneLoaded: onUnitySceneLoaded,
        onUnityMessage: (message) {
          // print('Received message from unity: ${message.toString()}');
          // Navigator.pop(context);
          if (message.toString().isNotEmpty) {
            // unityWidgetController.quit();
            unityWidgetController.pause();
            Navigator.pop(context, message.toString());
          }
        },
        fullscreen: true,
      ),
    );
  }
}
