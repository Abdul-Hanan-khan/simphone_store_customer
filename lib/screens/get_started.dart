import 'package:flutter/material.dart';
import 'package:sim_phone/screens/login.dart';
import 'package:sim_phone/screens/sign_up.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(size.height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const Image(
                    image: AssetImage("assets/images/mobiles.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.height * 0.02),
                child: Text(
                  "Buy your favourite number and more!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(size.height * 0.05, 0,
                    size.height * 0.05, size.height * 0.05),
                child: Text(
                  "Explore all the available numbers, Wifi and Mobile devices networks has to offer. Bought products will be delivered at your doorstep.  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const Login();
                          }),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade400,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.06,
                            vertical: size.height * 0.004),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const SignUp();
                          }),
                        );
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade400),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.06,
                            vertical: size.height * 0.004),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
