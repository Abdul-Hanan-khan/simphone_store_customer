import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:sim_phone/screens/get_started.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<OnbordingData> list = [
      // OnbordingData(
      //   image: const AssetImage("assets/images/choosing.png"),
      //   imageHeight: size.height * 0.3,
      //   imageWidth: size.width * 0.8,
      //   fit: BoxFit.contain,
      //   descPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      //   titleText: Text(
      //     "Log In or Sign Up",
      //     style: TextStyle(
      //       fontSize: size.height * 0.04,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   descText: Text(
      //     "You will need to sign up or log in depending upon if you already have an account. You will be forwarded to your account. In case you are an captain only system owner can provide access to captains after approving them, whereas the captains who already have access to their account will be forwarded to their dashboards.",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       fontSize: size.height * 0.02,
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      // ),
      OnbordingData(
        image: const AssetImage("assets/images/delivery-bike.png"),
        imageHeight: size.height * 0.3,
        imageWidth: size.width * 0.8,
        fit: BoxFit.contain,
        descPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        titleText: Text(
          "Captain's Access",
          style: TextStyle(
            fontSize: size.height * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
        descText: Text(
          "If you are a delivery captain you will have access to your dashboard where you will be able to see you orders completed and in-progress. You will be able to add new sim cards, devices, cell phones and change previous ones. You will also be able to see and edit your profile.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size.height * 0.02,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      OnbordingData(
        image: const AssetImage("assets/images/man.png"),
        imageHeight: size.height * 0.3,
        imageWidth: size.width * 0.8,
        fit: BoxFit.contain,
        descPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        titleText: Text(
          "Customer's Options",
          style: TextStyle(
            fontSize: size.height * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
        descText: Text(
          "If you are a user you will be able to browse through available sim cards of different networks, wifi devices and cell phones.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size.height * 0.02,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      OnbordingData(
        image: const AssetImage("assets/images/sim-toolkit.png"),
        imageHeight: size.height * 0.3,
        imageWidth: size.width * 0.8,
        fit: BoxFit.contain,
        descPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        titleText: Text(
          "Products",
          style: TextStyle(
            fontSize: size.height * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
        descText: Text(
          "If you like any sim card with a specific number you will be able to reserve that number for yourself by paying for a portion of the price, so that you can buy it later. You can also choose any other devices or cell phones available and buy them online and they will be delivered to you!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size.height * 0.02,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: IntroScreen(
          onbordingDataList: list,
          colors: const [
            //list of colors for per pages

            Colors.green
          ],
          pageRoute: MaterialPageRoute(
            builder: (context) => const GetStarted(),
          ),
          nextButton: Text(
            "NEXT",
            style: TextStyle(
              color: Colors.blue.shade700,
            ),
          ),
          lastButton: Text(
            "GOT IT",
            style: TextStyle(
              color: Colors.blue.shade700,
            ),
          ),
          skipButton: Text(
            "SKIP",
            style: TextStyle(
              color: Colors.blue.shade700,
            ),
          ),
          selectedDotColor: Colors.blue.shade700,
          unSelectdDotColor: Colors.grey,
        ),
      ),
    );
  }
}
