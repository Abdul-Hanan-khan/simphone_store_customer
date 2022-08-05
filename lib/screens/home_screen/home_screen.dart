import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sim_phone/screens/home_screen/side_menu.dart';

import 'catergory_screen/catergory__screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }


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

  static const List<Widget> data = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              // aspectRatio: 2.0,
              initialPage: 2,
            ),
            items: imgList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      // decoration: const BoxDecoration(color: Colors.amber),
                      child: Image.asset(i));
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
            itemCount: logo.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(name[index], logo[index]),
                      ));
                },
                child: Card(
                  elevation: 0,
                  // color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Image.asset(logo[index], height: 100, width: 100), Text(name[index])],
                  ),
                ),
              );
            },
          )
        ],
      ),
    ));
  }
}
