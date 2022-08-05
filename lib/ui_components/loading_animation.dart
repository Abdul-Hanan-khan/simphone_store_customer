import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(width: size.width * 0.07, height: size.width * 0.07, child:  CircularProgressIndicator(color: Colors.green.shade400,));
  }
}
