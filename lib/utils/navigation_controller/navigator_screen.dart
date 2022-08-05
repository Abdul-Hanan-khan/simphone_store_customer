import 'package:flutter/material.dart';

class Nav {
  Nav._();

  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void pushReplace(BuildContext context, Widget widget) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void pushAndRemoveAllRoute(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (Route route) => false);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
