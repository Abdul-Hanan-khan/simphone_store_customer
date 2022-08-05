import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sim_phone/models/api_response/get_user_api_response.dart';
import 'package:sim_phone/ui_components/loading_screen_animation.dart';

import '../../../bloc/drawer_cubit/drawer_cubit.dart' hide LoadingState;
import '../../../bloc/update_user_cubit/update_user_cubit.dart';
import '../../../common/common_variables.dart';
import '../../../ui_components/show_snack_bar.dart';
import '../../../utils/api_constants/api_constants.dart';
import '../../../utils/navigation_controller/navigator_screen.dart';
import '../../home_screen/catergory_screen/sims_no_screen/sim_detail_screen/google_map_search.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(this.userApiResponse, {Key? key}) : super(key: key);
  final GetUserApiResponse? userApiResponse;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();

  XFile? _image;
  String? profileImage;
  int isCurrentAddress = 0;

  Future _imgFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    lat = 0;
    long = 0;
    city = '';
    registrationAddress = '';
    currentRegistrationAddress = widget.userApiResponse?.area ?? "";
    currentCity = '';
    profileImage = widget.userApiResponse?.avatar;
    _nameTextController.text = widget.userApiResponse?.name ?? "";
    _phoneTextController.text = widget.userApiResponse?.phone ?? "";
    super.initState();
  }

  backScreen(BuildContext context) {
    context.read<DrawerCubit>().getUser();
    Nav.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => UpdateUserCubit(),
      child: BlocConsumer<UpdateUserCubit, UpdateUserState>(
        listener: (context, state) {
          if (state is FailedToUpdateUser) {
            showSnackBar(context, state.message);
          }
          if (state is SuccessfullyUpdateUser) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            backScreen(context);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: SafeArea(
                child: Scaffold(
              body: ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Center(
                    child: Stack(children: [
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
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.01),
                    child: TextField(
                      controller: _nameTextController,
                      style: TextStyle(fontSize: size.height * 0.025),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(size.height * 0.02),
                        hintText: "please Enter Name",
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
                          style: TextStyle(fontSize: size.height * 0.025),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.01),
                    child: TextField(
                      controller: _phoneTextController,
                      style: TextStyle(fontSize: size.height * 0.025),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(size.height * 0.02),
                        hintText: "please Enter Phone Number",
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
                          "Phone",
                          style: TextStyle(fontSize: size.height * 0.025),
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
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
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
                  if (registrationAddress.isNotEmpty && isCurrentAddress == 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GoogleMapSearch(),
                              )).then((value) => setState(() {}));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
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
                  if (registrationAddress.isEmpty && isCurrentAddress == 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GoogleMapSearch(),
                              )).then((value) => setState(() {}));
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15, top: 3),
                          margin: EdgeInsets.only(bottom: size.height * 0.02),
                          width: size.width * 0.9,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            'Search Address',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.05),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                      ),
                      onPressed: () {
                        if (_nameTextController.text.isEmpty) {
                          showSnackBar(context, "Please Enter Name");
                        } else if (_phoneTextController.text.isEmpty) {
                          showSnackBar(context, "Please Enter Phone Number");
                        } else {
                          if (_image == null && registrationAddress.isNotEmpty) {
                            context.read<UpdateUserCubit>().updateUser(
                                  name: _nameTextController.text,
                                  phone: _phoneTextController.text,
                                  address: registrationAddress,
                                );
                          }
                          if (_image == null && registrationAddress.isEmpty) {
                            context.read<UpdateUserCubit>().updateUser(
                                  name: _nameTextController.text,
                                  phone: _phoneTextController.text,
                                  address: currentRegistrationAddress,
                                );
                          }
                          if (_image != null && registrationAddress.isNotEmpty) {
                            context.read<UpdateUserCubit>().updateUser(
                                name: _nameTextController.text, phone: _phoneTextController.text, address: registrationAddress, profileImage: _image);
                          } else if (_image != null && registrationAddress.isEmpty) {
                            context.read<UpdateUserCubit>().updateUser(
                                name: _nameTextController.text,
                                phone: _phoneTextController.text,
                                address: currentRegistrationAddress,
                                profileImage: _image);
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.012),
                        child: Text(
                          "Update",
                          style: TextStyle(fontSize: size.height * 0.025),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
