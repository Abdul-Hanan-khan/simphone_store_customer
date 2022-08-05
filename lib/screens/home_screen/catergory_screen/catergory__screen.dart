import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sim_phone/screens/home_screen/catergory_screen/all_devices_screen/all_devices_screen.dart';
import 'package:sim_phone/screens/home_screen/catergory_screen/all_phone_screen/all_phone_screen.dart';
import 'package:sim_phone/screens/home_screen/catergory_screen/sims_no_screen/sim_no_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(this.name, this.logo, {Key? key}) : super(key: key);
  final String name;
  final String logo;
  
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> imgList = [
    'assets/images/sim.png',
    'assets/images/phone.png',
    'assets/images/wifi.png',
  ];

  final List<String> logo = [
    'assets/images/sims.png',
    'assets/images/wifid.png',
    'assets/images/smartphone.png',
  ];
  final List<String> name = [
    'SIMS',
    'WIFI DEVICES',
    'CELL PHONE',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                // enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
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
              height: 20,
            ),
            GridView.builder(
              itemCount: name.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if (name[index] == "SIMS") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SimsNoScreen(widget.name),
                          ));
                    }
                    if (name[index] == "WIFI DEVICES") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllDevicesScreen(widget.name),
                          ));
                    }
                    if (name[index] == "CELL PHONE") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllPhonesScreen(widget.name),
                          ));
                    }
                  },
                  child: Card(
                    elevation: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Image.asset(logo[index], height: 100, width: 100), const SizedBox(height: 16), Text(name[index])],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
