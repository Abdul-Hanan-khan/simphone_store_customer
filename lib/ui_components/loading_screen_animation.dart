import 'package:flutter/material.dart';

import 'loading_animation.dart';

class LoadingScreenAnimation extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingScreenAnimation({Key? key, required this.child, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black54,
            alignment: Alignment.center,
            child: const LoadingAnimation(),
          ),
      ],
    );
  }
}
