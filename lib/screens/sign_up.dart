import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sim_phone/common/common_variables.dart';

import '../bloc/auth_cubit/signup_cubit/sign_up_cubit.dart';
import '../ui_components/loading_screen_animation.dart';
import '../ui_components/show_snack_bar.dart';
import '../utils/api_constants/api_constants.dart';
import 'home_screen/catergory_screen/sims_no_screen/sim_detail_screen/google_map_search.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool visibility = false;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _cnicTextController = TextEditingController();

  XFile? _image;
  String? profileImage;

  void onVisIconPressed() {
    setState(() {
      visibility = !visibility;
    });
  }

  int isCurrentAddress = 0;

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      currentCity = placeMarks[0].locality!;
      currentLat = position.latitude;
      currentLong = position.longitude;
      currentRegistrationAddress =
          '${placeMarks[0].street} ${placeMarks[0].subLocality} ${placeMarks[0].locality} ${placeMarks[0].country}';
    });
  }

  @override
  void initState() {
    lat = 0;
    long = 0;
    city = '';
    registrationAddress = '';
    currentLat = 0;
    currentLong = 0;
    currentRegistrationAddress = '';
    currentCity = '';
    getCurrentLocation();
    super.initState();
  }

  Future _imgFromGallery() async {
    final XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
      // fileImage=File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailed) {
            showSnackBar(context, state.message);
          }
          if (state is SignUpSuccessful) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white.withOpacity(0.8),
                body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02,
                            horizontal: size.width * 0.02),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new,
                              size: size.height * 0.04),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image(
                            width: size.width * 0.7,
                            height: size.width * 0.4,
                            image: const AssetImage(
                                "assets/images/simphonelogo.png"),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Stack(children: [
                            Center(
                              child: Container(
                                height: size.height * 0.2,
                                width: size.width * 0.4,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white10,
                                  // borderRadius: BorderRadius.circular(80),
                                ),
                                child: _image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.file(
                                          File(_image!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: profileImage == null
                                            ? Image.network(
                                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "${ApiConstants.baseUrl}${profileImage!}",
                                                fit: BoxFit.cover,
                                              )),
                              ),
                            ),
                            Positioned(
                                bottom: size.width * 0.01,
                                right: size.width * 0.3,
                                child: GestureDetector(
                                  onTap: () {
                                    _imgFromGallery();
                                  },
                                  child: Container(
                                    height: size.height * 0.04,
                                    width: size.height * 0.04,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: const Icon(Icons.edit),
                                  ),
                                ))
                          ]),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.1,
                                size.height * 0.001,
                                size.width * 0.1,
                                size.height * 0.01),
                            child: TextField(
                              controller: _nameTextController,
                              style: TextStyle(fontSize: size.height * 0.025),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(size.height * 0.02),
                                hintText: "John Doe",
                                hintStyle: TextStyle(
                                  fontSize: size.height * 0.025,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                label: Text(
                                  "Name",
                                  style:
                                      TextStyle(fontSize: size.height * 0.025),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.1,
                                size.height * 0.001,
                                size.width * 0.1,
                                size.height * 0.01),
                            child: TextField(
                              controller: _cnicTextController,
                              maxLength: 13,
                              style: TextStyle(fontSize: size.height * 0.025),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(size.height * 0.02),
                                hintText: "xxxxxxxxxxxxx",
                                hintStyle: TextStyle(
                                  fontSize: size.height * 0.025,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                label: Text(
                                  "CNIC",
                                  style:
                                      TextStyle(fontSize: size.height * 0.025),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.1,
                                size.height * 0.001,
                                size.width * 0.1,
                                size.height * 0.01),
                            child: TextField(
                              controller: _emailTextController,
                              style: TextStyle(fontSize: size.height * 0.025),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(size.height * 0.02),
                                hintText: "Johndoe@mail.com",
                                hintStyle: TextStyle(
                                  fontSize: size.height * 0.025,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                label: Text(
                                  "Email",
                                  style:
                                      TextStyle(fontSize: size.height * 0.025),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.1,
                                size.height * 0.001,
                                size.width * 0.1,
                                size.height * 0.01),
                            child: TextField(
                              controller: _phoneTextController,
                              style: TextStyle(fontSize: size.height * 0.025),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(size.height * 0.02),
                                hintText: "03xxxxxxxxx",
                                hintStyle: TextStyle(
                                  fontSize: size.height * 0.025,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                label: Text(
                                  "Contact No",
                                  style:
                                      TextStyle(fontSize: size.height * 0.025),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.1,
                                size.height * 0.001,
                                size.width * 0.1,
                                size.height * 0.01),
                            child: TextField(
                              controller: _passwordTextController,
                              obscureText: visibility ? false : true,
                              style: TextStyle(fontSize: size.height * 0.025),
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  child: Icon(
                                    visibility
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: size.height * 0.03,
                                  ),
                                  onTap: () {
                                    onVisIconPressed();
                                  },
                                ),
                                contentPadding:
                                    EdgeInsets.all(size.height * 0.02),
                                hintText: "xxxxx",
                                hintStyle: TextStyle(
                                  fontSize: size.height * 0.025,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                label: Text(
                                  "Password",
                                  style:
                                      TextStyle(fontSize: size.height * 0.025),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.grey,
                                    value: 0,
                                    onChanged: (value) {
                                      setState(() {
                                        isCurrentAddress = value as int;
                                      });
                                    },
                                    groupValue: isCurrentAddress,
                                  ),
                                  Text(
                                    'Current location',
                                    style: TextStyle(
                                      fontSize: size.width * 0.034,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Colors.grey,
                                    value: 1,
                                    onChanged: (value) {
                                      setState(() {
                                        isCurrentAddress = value as int;
                                      });
                                    },
                                    groupValue: isCurrentAddress,
                                  ),
                                  Text(
                                    'Search address',
                                    style: TextStyle(
                                      fontSize: size.width * 0.034,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          if (isCurrentAddress == 0)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined),
                                        SizedBox(
                                          width: size.width * 0.035,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.64,
                                          child: Text(
                                            currentRegistrationAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 0.04,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.refresh,
                                          color: Colors.black,
                                          size: size.width * 0.05,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'City: ',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: size.width * 0.04,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          currentCity,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: size.width * 0.04,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (registrationAddress.isNotEmpty &&
                              isCurrentAddress == 1)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const GoogleMapSearch(),
                                      )).then((value) => setState(() {}));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.location_on_outlined),
                                          SizedBox(
                                            width: size.width * 0.035,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.7,
                                            child: Text(
                                              registrationAddress,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'City: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: size.width * 0.04,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            city,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 0.04,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (registrationAddress.isEmpty &&
                              isCurrentAddress == 1)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const GoogleMapSearch(),
                                      )).then((value) => setState(() {}));
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 3),
                                  margin: EdgeInsets.only(
                                      bottom: size.height * 0.02),
                                  width: size.width * 0.85,
                                  height: size.height * 0.07,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Text(
                                    'Search Address',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.green.shade400),
                              ),
                              onPressed: () {
                                if (_nameTextController.text.isEmpty) {
                                  showSnackBar(context, "Please Enter Name");
                                } else if (_cnicTextController.text.isEmpty) {
                                  showSnackBar(
                                      context, "Please Enter Correct CNIC");
                                } else if (_emailTextController.text.isEmpty) {
                                  showSnackBar(context, "Please Enter Email");
                                } else if (_passwordTextController
                                    .text.isEmpty) {
                                  showSnackBar(
                                      context, "Please Enter Password");
                                } else if (_phoneTextController.text.isEmpty) {
                                  showSnackBar(
                                      context, "Please Enter Phone No");
                                } else {
                                  if (_image != null) {
                                    /// with image xfile
                                    if (registrationAddress.isNotEmpty) {
                                      context.read<SignUpCubit>().signUp(
                                          userName: _nameTextController.text,
                                          password:
                                              _passwordTextController.text,
                                          email: _emailTextController.text,
                                          phoneNo: _phoneTextController.text,
                                          address: registrationAddress,
                                          cnic: _cnicTextController.text,
                                          long: currentLong.toString(),
                                          lat: currentLat.toString(),
                                          imageFile: _image);
                                    } else {
                                      context.read<SignUpCubit>().signUp(
                                          userName: _nameTextController.text,
                                          password:
                                              _passwordTextController.text,
                                          email: _emailTextController.text,
                                          phoneNo: _phoneTextController.text,
                                          address: currentRegistrationAddress,
                                          cnic: _cnicTextController.text,
                                          long: currentLong.toString(),
                                          lat: currentLat.toString(),
                                          imageFile: _image);
                                    }
                                  } else {
                                    ///without image xfile
                                    if (registrationAddress.isNotEmpty) {
                                      context.read<SignUpCubit>().signUp(
                                          userName: _nameTextController.text,
                                          password:
                                              _passwordTextController.text,
                                          email: _emailTextController.text,
                                          phoneNo: _phoneTextController.text,
                                          address: registrationAddress,
                                          cnic: _cnicTextController.text);
                                    } else {
                                      context.read<SignUpCubit>().signUp(
                                          userName: _nameTextController.text,
                                          password:
                                              _passwordTextController.text,
                                          email: _emailTextController.text,
                                          phoneNo: _phoneTextController.text,
                                          address: currentRegistrationAddress,
                                          cnic: _cnicTextController.text);
                                    }
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(size.height * 0.012),
                                child: Text(
                                  "Create Account",
                                  style:
                                      TextStyle(fontSize: size.height * 0.025),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
