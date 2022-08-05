import 'package:flutter/material.dart';

String registrationAddress = '';
double lat = 0;
double long = 0;
String city = '';
String checkRequest = '';

int noOfRequest = 0;
int noOfAcceptRequest = 0;
var docList;


String currentCity = '';
double currentLat = 0;
double currentLong = 0;
String currentRegistrationAddress = '';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
