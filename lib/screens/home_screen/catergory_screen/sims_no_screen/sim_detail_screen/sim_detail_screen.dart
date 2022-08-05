import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sim_phone/bloc/all_sim_cubit/all_sims_cubit.dart';
import 'package:sim_phone/common/common_variables.dart';
import 'package:sim_phone/models/api_response/order_product_api_response.dart';
import 'package:sim_phone/ui_components/loading_screen_animation.dart';
import 'package:sim_phone/ui_components/show_snack_bar.dart';

import '../../../../../models/data_models/sim.dart';
import '../../../../../utils/navigation_controller/navigator_screen.dart';
import 'google_map_search.dart';

class SimDetailScreen extends StatefulWidget {
  const SimDetailScreen(this.sim, {Key? key}) : super(key: key);
  final Sims sim;

  @override
  _SimDetailScreenState createState() => _SimDetailScreenState();
}

class _SimDetailScreenState extends State<SimDetailScreen> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  int isCurrentAddress = 0;

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      currentCity = placeMarks[0].locality!;
      currentLat = position.latitude;
      currentLong = position.longitude;
      currentRegistrationAddress = '${placeMarks[0].street} ${placeMarks[0].subLocality} ${placeMarks[0].locality} ${placeMarks[0].country}';
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
    _nameTextController.text = GetStorage().read('name');
    _emailTextController.text = GetStorage().read('email');
    _phoneTextController.text = GetStorage().read('phone');
    getCurrentLocation();
    super.initState();
  }

  _showDialog(OrderProductApiResponse orderProductApiResponse) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Order Create Successfully',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Text(
                          orderProductApiResponse.order?.id ?? "",
                          maxLines: 3,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "${orderProductApiResponse.order?.product?.price}",
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "${orderProductApiResponse.order?.product?.nameOrNum}",
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> backScreen(BuildContext context) async {
    context.read<AllSimsCubit>().allSims();
    Nav.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AllSimsCubit(),
      child: BlocConsumer<AllSimsCubit, AllSimsState>(
        listener: (context, state) {
          if (state is FailedToOrderSim) {
            showSnackBar(context, state.message);
          }
          if (state is SimOrderSuccessfully) {
            _showDialog(state.orderProductApiResponse);
            showSnackBar(context, state.message, type: SnackBarType.success);
            // backScreen(context);
            Future.delayed(const Duration(seconds: 3)).then((value) {
              backScreen(context);
              Nav.pop(context);
            });
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: SafeArea(
                child: Scaffold(
              appBar: AppBar(
                title: const Text("Order Sim"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.sim.series} - ${widget.sim.no}",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "25% OFF",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.sim.package!.sameNetworkMins}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "On-net Min's",
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.sim.package!.otherNetworkMins}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Off-net Min's",
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.sim.package!.data}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "MB's",
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.sim.price} PKR",
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16),
                              ),
                              const Text(
                                "Price",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${widget.sim.package!.messages}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "SMS",
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
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
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                        child: TextField(
                          controller: _emailTextController,
                          style: TextStyle(fontSize: size.height * 0.025),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(size.height * 0.02),
                            hintText: "John123@mail.com",
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
                              style: TextStyle(fontSize: size.height * 0.025),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
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
                        Container(
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
                      if (registrationAddress.isNotEmpty && isCurrentAddress == 1)
                        InkWell(
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
                      if (registrationAddress.isEmpty && isCurrentAddress == 1)
                        InkWell(
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
                            width: size.width * 0.85,
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
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          // shape: MaterialStateProperty.all(
                          //   RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          // ),
                          backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                        ),
                        onPressed: () {
                          print(registrationAddress);
                          print(lat.toString());
                          print(long.toString());

                          if (_nameTextController.text.isEmpty) {
                            showSnackBar(context, "Please Enter Name");
                          } else if (_emailTextController.text.isEmpty) {
                            showSnackBar(context, "Please Enter Name");
                          } else if (_emailTextController.text.isEmpty) {
                            showSnackBar(context, "Please Enter Name");
                          } else {
                            if (registrationAddress.isNotEmpty) {
                              context.read<AllSimsCubit>().simOrder(
                                  simId: widget.sim.id!,
                                  email: _emailTextController.text,
                                  name: _nameTextController.text,
                                  address: registrationAddress,
                                  phone: _phoneTextController.text,
                                  lat: lat.toString(),
                                  long: long.toString());
                            } else {
                              context.read<AllSimsCubit>().simOrder(
                                  simId: widget.sim.id!,
                                  email: _emailTextController.text,
                                  name: _nameTextController.text,
                                  address: currentRegistrationAddress,
                                  phone: _phoneTextController.text,
                                  lat: currentLat.toString(),
                                  long: currentLong.toString());
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(size.height * 0.012),
                          child: Text(
                            "Order Now",
                            style: TextStyle(fontSize: size.height * 0.025),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
