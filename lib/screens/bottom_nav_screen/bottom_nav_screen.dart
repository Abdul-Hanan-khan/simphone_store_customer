import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sim_phone/screens/home_screen/home_screen.dart';
import 'package:sim_phone/screens/home_screen/order_screen/order_screen.dart';
import 'package:sim_phone/screens/home_screen/side_menu.dart';
import 'package:sim_phone/screens/login.dart';

import '../home_screen/catergory_screen/catergory__screen.dart';
import 'map_screen.dart';

class BottomNavScreen extends StatefulWidget {

  int ?tabNo;


  BottomNavScreen(this.tabNo);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {

  final List<String> imgList = [
    'assets/images/sim.png',
    'assets/images/phone.png',
    'assets/images/wifi.png',
  ];

  final List<String> logo = [
    'assets/images/jaz.png',
    'assets/images/ufone.png',
    'assets/images/zong.png',
    'assets/images/telenor.png',
  ];
  final List<String> name = [
    'JAZZ',
    'UFONE',
    'ZONG',
    'TELENOR',
  ];

  List<Widget> tab = <Widget>[
    MapScreen(),
    HomeScreen(),
    OrderScreen(),
  ];




  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: tab[widget.tabNo!],
      bottomNavigationBar: SalomonBottomBar(
        curve: Curves.linear,
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.01),
        currentIndex: widget.tabNo!,
        onTap: (i) {
          setState(
            () {
              widget.tabNo = i;
            },
          );
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.map),
            title: const Text("Map"),
            selectedColor: Colors.red.shade400,
          ),

          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.green.shade400,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.delivery_dining),
            title: const Text("Order"),
            selectedColor: Colors.green.shade400,
          ),
        ],
      ),
    ));
  }
}
