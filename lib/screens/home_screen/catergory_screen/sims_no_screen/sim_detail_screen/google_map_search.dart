import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:sim_phone/common/common_variables.dart';

class GoogleMapSearch extends StatefulWidget {
  const GoogleMapSearch({Key? key}) : super(key: key);

  @override
  _GoogleMapSearchState createState() => _GoogleMapSearchState();
}

class _GoogleMapSearchState extends State<GoogleMapSearch> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          width: size.width,
          alignment: Alignment.topCenter,
          child: SearchGooglePlacesWidget(
            placeType: PlaceType.address,
            // PlaceType.cities, PlaceType.geocode, PlaceType.region etc
            placeholder: 'Enter the address',
            apiKey: 'AIzaSyCcikg7LaUScQR54u4O6yNPBy7Y0YiGsWM',
            onSearch: (Place place) {},
            onSelected: (Place place) async {
              place.geolocation!.then((value) async {
                print('lat long ${value!.coordinates.toString()}');
                registrationAddress = place.description.toString();
                lat = double.parse(
                  value.coordinates.toString().substring(
                    value.coordinates.toString().indexOf('(') + 1,
                    value.coordinates.toString().indexOf(','),
                  ),
                );
                print(lat);
                long = double.parse(
                  value.coordinates.toString().substring(
                    value.coordinates.toString().indexOf(',') + 1,
                    value.coordinates.toString().indexOf(')'),
                  ),
                );
                List<Placemark> placeMarks = await placemarkFromCoordinates(
                  double.parse(
                    value.coordinates.toString().substring(
                      value.coordinates.toString().indexOf('(') + 1,
                      value.coordinates.toString().indexOf(','),
                    ),
                  ),
                  double.parse(
                    value.coordinates.toString().substring(
                      value.coordinates.toString().indexOf(',') + 1,
                      value.coordinates.toString().indexOf(')'),
                    ),
                  ),
                );
                city = placeMarks[0].locality.toString();
                setState(() {});
              }).whenComplete(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
      ),
    );
  }
}