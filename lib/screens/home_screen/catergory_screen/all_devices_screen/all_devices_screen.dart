import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/all_devices_cubit/all_devices_cubit.dart';
import '../../../../models/api_response/all_devices_api_response.dart';
import '../../../../ui_components/loading_screen_animation.dart';
import '../../../../ui_components/show_snack_bar.dart';
import '../../../../utils/api_constants/api_constants.dart';
import '../../../../utils/navigation_controller/navigator_screen.dart';
import 'device_detail_screen/device_detail_screen.dart';

class AllDevicesScreen extends StatefulWidget {
  const AllDevicesScreen(this.name, {Key? key}) : super(key: key);
  final String name;

  @override
  _AllDevicesScreenState createState() => _AllDevicesScreenState();
}

class _AllDevicesScreenState extends State<AllDevicesScreen> {
  List<Devices> allDevices = [];

  final TextEditingController qty = TextEditingController();

  @override
  void initState() {
    context.read<AllDevicesCubit>().allDevices();
    super.initState();
  }

  // _showDialog(Devices data) {
  //   Size size = MediaQuery.of(context).size;
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       print(data.name);
  //       print(data.name);
  //       print(data.name);
  //       return SizedBox(
  //         child: AlertDialog(
  //           content: StatefulBuilder(
  //             builder: (context, setState) {
  //               return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   ListTile(
  //                     leading: Image.network("${ApiConstants.baseUrl}${data.pics?.first ?? ''}"),
  //                     //
  //                     title: Text(
  //                       data.name ?? '',
  //                       style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
  //                     ),
  //                     // subtitle: Text(userSport),
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       const Text(
  //                         'Price',
  //                         style: TextStyle(color: Colors.blue, fontSize: 12),
  //                       ),
  //                       Text(
  //                         "${data.price}",
  //                         style: const TextStyle(color: Colors.grey, fontSize: 12),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       const Text(
  //                         'Network',
  //                         style: TextStyle(color: Colors.blue, fontSize: 12),
  //                       ),
  //                       Text(
  //                         "${data.network}",
  //                         style: const TextStyle(color: Colors.grey, fontSize: 12),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       const Text(
  //                         'Quantity',
  //                         style: TextStyle(color: Colors.blue, fontSize: 12),
  //                       ),
  //                       SizedBox(
  //                         width: 100,
  //                         child: TextField(
  //                           controller: qty,
  //                           style: const TextStyle(fontSize: 12),
  //                           decoration: const InputDecoration(
  //                             hintText: "Enter Quantity",
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Center(
  //                     child: ElevatedButton(
  //                       style: ButtonStyle(
  //                         shape: MaterialStateProperty.all(
  //                           RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                         backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
  //                       ),
  //                       onPressed: () {
  //                         if (qty.text.isEmpty) {
  //                           showSnackBar(context, "Please Enter Quantity");
  //                         } else {
  //                           context.read<AllDevicesCubit>().addDevice(id: data.id!, dType: data.deviceType!, qty: int.parse(qty.text));
  //                         }
  //                       },
  //                       child: Padding(
  //                         padding: EdgeInsets.all(size.height * 0.012),
  //                         child: Text(
  //                           "Add Device",
  //                           style: TextStyle(fontSize: size.height * 0.025),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AllDevicesCubit, AllDevicesState>(
      listener: (context, state) {
        if (state is FailedToFetchedDevices) {
          showSnackBar(context, state.message);
        }
        if (state is FailedToOrderDevice) {
          showSnackBar(context, state.message);
        }
        if (state is AllDevicesFetchedSuccessfully) {
          allDevices.clear();
          allDevices = state.devices;
        }
        if (state is OrderDeviceSuccessfully) {
          showSnackBar(context, state.message, type: SnackBarType.success);
        }
      },
      builder: (context, state) {
        return LoadingScreenAnimation(
          isLoading: state is LoadingState,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("All Wifi Device"),
            ),
            body: ListView.builder(
              itemCount: allDevices.length,
              itemBuilder: (BuildContext context, int index) {
                if (allDevices[index].network == widget.name.toLowerCase()) {
                  return Card(
                    color: Colors.grey.shade200,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                      child: Column(
                        children: [
                          Image.network("${ApiConstants.baseUrl}${allDevices[index].pics?.first}", height: 100),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Device Type",
                                    style: TextStyle(fontSize: size.height * 0.020, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  Text(
                                    allDevices[index].deviceType ?? '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: size.height * 0.015, color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Device Name",
                                    style: TextStyle(fontSize: size.height * 0.020, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  Text(
                                    allDevices[index].name ?? '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: size.height * 0.015, color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                                children: [
                                  Text(
                                    "Device Price",
                                    style: TextStyle(fontSize: size.height * 0.020, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  Text(
                                    "${allDevices[index].price} PKR",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: size.height * 0.015, color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                                ),
                                onPressed: () {

                                  Nav.push(context, DeviceDetailScreen(allDevices[index]));
                                 // context.read<AllDevicesCubit>().orderDevice(productId: allDevices[index].id!, type: allDevices[index].deviceType!);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(size.height * 0.012),
                                  child: Text(
                                    "Buy Now",
                                    style: TextStyle(fontSize: size.height * 0.025),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
