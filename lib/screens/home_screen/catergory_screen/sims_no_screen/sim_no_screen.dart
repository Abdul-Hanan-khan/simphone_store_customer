import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sim_phone/screens/home_screen/catergory_screen/sims_no_screen/sim_detail_screen/sim_detail_screen.dart';
import 'package:sim_phone/ui_components/loading_screen_animation.dart';

import '../../../../bloc/all_sim_cubit/all_sims_cubit.dart';
import '../../../../common/common_variables.dart';
import '../../../../models/api_response/all_sim_api_response.dart';
import '../../../../ui_components/show_snack_bar.dart';
import '../../../../utils/navigation_controller/navigator_screen.dart';

class SimsNoScreen extends StatefulWidget {
  const SimsNoScreen(this.name, {Key? key}) : super(key: key);
  final String name;

  @override
  _SimsNoScreenState createState() => _SimsNoScreenState();
}

class _SimsNoScreenState extends State<SimsNoScreen> {
  List<CaptainSims> allSims = [];
  String? serialValue;
  final TextEditingController controller = TextEditingController();

  final List<String> jazz = [
    "0300",
    "0301",
    "0302",
    "0303",
    "0304",
    "0305",
    "0306",
    "0307",
    "0308",
    "0309",
    "0320",
    "0321",
    "0322",
    "0323",
    "0324",
    "0325",
  ];
  final List<String> zong = [
    "0310",
    "0311",
    "0312",
    "0313",
    "0314",
    "0315",
    "0316",
    "0317",
    "0318",
    "0319",
  ];
  final List<String> ufone = [
    "0330",
    "0331",
    "0332",
    "0333",
    "0334",
    "0335",
    "0336",
    "0337",
  ];
  final List<String> telenor = ["0340", "0341", "0342", "0343", "0344", "0345", "0346", "0347", "0348", "0349"];

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
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => AllSimsCubit()..allSims(),
        child: BlocConsumer<AllSimsCubit, AllSimsState>(listener: (context, state) {
          if (state is FailedToFetchedSims) {
            showSnackBar(context, state.message);
          }
          if (state is FailedToOrderSim) {
            showSnackBar(context, state.message);
          }
          if (state is AllSimsFetchedSuccessfully) {
            allSims.clear();
            allSims = state.allSims;
          }
          if (state is SimOrderSuccessfully) {
            showSnackBar(context, state.message, type: SnackBarType.success);
          }
        }, builder: (context, state) {
          return LoadingScreenAnimation(
              isLoading: state is LoadingState,
              child: SafeArea(
                  child: Scaffold(
                      body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                        expandedHeight: 120.0,
                        pinned: true,
                        // snap: true,
                        floating: true,
                        title: const Text("SIMS"),
                        bottom: AppBar(
                          automaticallyImplyLeading: false,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (widget.name.toLowerCase() == "jazz")
                                  ? Container(
                                      height: 45,
                                      width: size.width / 2.25,
                                      decoration:
                                          BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(width: 1)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          borderRadius: BorderRadius.circular(20),
                                          value: serialValue != null ? serialValue : null,
                                          hint: const Text("select serial"),
                                          icon: const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          style: TextStyle(
                                            fontSize: size.height * 0.025,
                                            // color: Colors.grey.shade800,
                                          ),
                                          items: jazz.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value, style: const TextStyle(color: Colors.black)),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              serialValue = newValue!;
                                              context.read<AllSimsCubit>().searchSims(series: serialValue);
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  : (widget.name.toLowerCase() == "zong")
                                      ? Container(
                                          height: 45,
                                          width: size.width / 2.25,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(width: 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              underline: const SizedBox(),
                                              borderRadius: BorderRadius.circular(20),
                                              value: serialValue != null ? serialValue : null,
                                              hint: const Text("select serial"),
                                              icon: const Icon(Icons.arrow_drop_down),
                                              elevation: 16,
                                              style: TextStyle(
                                                fontSize: size.height * 0.025,
                                                // color: Colors.grey.shade800,
                                              ),
                                              items: zong.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value, style: const TextStyle(color: Colors.black)),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  serialValue = newValue!;
                                                  context.read<AllSimsCubit>().searchSims(series: serialValue);
                                                });
                                              },
                                            ),
                                          ),
                                        )
                                      : (widget.name.toLowerCase() == "ufone")
                                          ? Container(
                                              height: 45,
                                              width: size.width / 2.25,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(width: 1)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  underline: const SizedBox(),
                                                  borderRadius: BorderRadius.circular(20),
                                                  value: serialValue != null ? serialValue : null,
                                                  hint: const Text("select serial"),
                                                  icon: const Icon(Icons.arrow_drop_down),
                                                  elevation: 16,
                                                  style: TextStyle(
                                                    fontSize: size.height * 0.025,
                                                    // color: Colors.grey.shade800,
                                                  ),
                                                  items: ufone.map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value, style: const TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      serialValue = newValue!;
                                                      context.read<AllSimsCubit>().searchSims(series: serialValue);
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 45,
                                              width: size.width / 2.25,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(width: 1)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  underline: const SizedBox(),
                                                  borderRadius: BorderRadius.circular(20),
                                                  value: serialValue != null ? serialValue : null,
                                                  hint: const Text("select serial"),
                                                  icon: const Icon(Icons.arrow_drop_down),
                                                  elevation: 16,
                                                  style: TextStyle(
                                                    fontSize: size.height * 0.025,
                                                    // color: Colors.grey.shade800,
                                                  ),
                                                  items: telenor.map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value, style: const TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      serialValue = newValue!;
                                                      context.read<AllSimsCubit>().searchSims(series: serialValue);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                              SizedBox(
                                height: 45,
                                width: size.width / 2.25,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: controller,
                                  onChanged: (value) {
                                    searchResult(context);
                                  },
                                  onSubmitted: (value) {
                                    searchResult(context);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(top: 5, left: 15),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        context.read<AllSimsCubit>().searchSims(no: controller.text);
                                      },
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "1123455",
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          elevation: 5,
                        )),
                  ];
                },
                body: ListView.builder(
                  itemCount: allSims.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // for (int i = 0; i < allSims[index].sims!.length; i++) {
                      // if (allSims[index].sims![i].network == widget.name.toLowerCase()) {
                        return Card(
                          color: Colors.grey.shade200,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                         CircleAvatar(child:  Image.asset("assets/images/delivery-bike.png",height: 25),backgroundColor: Colors.white10),
                                        const SizedBox(width: 10,),
                                        Text(
                                          allSims[index].captain?.name ?? "",
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on),
                                        Text(
                                          allSims[index].captain?.area ?? "",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                for (int i = 0; i < allSims[index].sims!.length; i++)
                                  (allSims[index].sims![i].network == widget.name.toLowerCase()) ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${allSims[index].sims![i].series} - ${allSims[index].sims![i].no}",
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          (allSims[index].sims![i].discount != 0) ? Text(
                                             "${allSims[index].sims![i].discount} % OFF",
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                                          ): const SizedBox(),
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
                                                "${allSims[index].sims![i].package!.sameNetworkMins}",
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
                                                "${allSims[index].sims![i].package!.otherNetworkMins}",
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
                                                "${allSims[index].sims![i].package!.data}",
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
                                              Column(
                                                children: [
                                                  (allSims[index].sims![i].discount != 0) ? Text(
                                                    "${allSims[index].sims![i].price} PKR",
                                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16,decoration: TextDecoration.lineThrough),
                                                  ) :Text(
                                                    "${allSims[index].sims![i].price} PKR",
                                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16),
                                                  ),
                                                  (allSims[index].sims![i].discount != 0) ? Text(
                                                    "${allSims[index].sims![i].discountPrice} PKR",
                                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16),
                                                  ) : const SizedBox(),
                                                ],
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
                                                "${allSims[index].sims![i].package!.messages}",
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                              const Text(
                                                "SMS",
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      (allSims[index].sims![i].available == true) ? ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                                        ),
                                        onPressed: () {
                                          Nav.push(context, SimDetailScreen(allSims[index].sims![i]));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(size.height * 0.012),
                                          child: Text(
                                            "Buy Now",
                                            style: TextStyle(fontSize: size.height * 0.025),
                                          ),
                                        ),
                                      ):ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.grey),
                                        ),
                                        onPressed: () {
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(size.height * 0.012),
                                          child: Text(
                                            "Sold Out",
                                            style: TextStyle(fontSize: size.height * 0.025),
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ) : const SizedBox()
                              ],
                            ),
                          ),
                        );
                      // } else {
                      //   return const SizedBox();
                      // }
                    // }
                    // return const SizedBox();
                  },
                ),
              ))));
        }));
  }

  Future<void> searchResult(BuildContext context) async {
    if (controller.text.isEmpty) {
      context.read<AllSimsCubit>().allSims();
    } else {
      await context.read<AllSimsCubit>().searchSims(no: controller.text);
    }
  }
}
