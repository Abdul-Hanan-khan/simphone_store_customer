import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sim_phone/models/data_models/sim.dart';
import 'package:sim_phone/ui_components/loading_screen_animation.dart';
import 'package:sim_phone/ui_components/show_snack_bar.dart';

import '../../../bloc/captain_sims_cubit/captain_sims_cubit.dart';
import '../../../utils/navigation_controller/navigator_screen.dart';
import '../../home_screen/catergory_screen/sims_no_screen/sim_detail_screen/sim_detail_screen.dart';

class CaptainSimScreen extends StatefulWidget {
  const CaptainSimScreen(this.message, this.id, {Key? key}) : super(key: key);
  final String message;
  final String id;

  @override
  _CaptainSimScreenState createState() => _CaptainSimScreenState();
}

class _CaptainSimScreenState extends State<CaptainSimScreen> {
  List<Sims> sims = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CaptainSimsCubit()..allCaptainSims(id: widget.id),
      child: BlocConsumer<CaptainSimsCubit, CaptainSimsState>(
        listener: (context, state) {
          if (state is FailedToFetchedCaptainSims) {
            showSnackBar(context, state.message);
          }
          if (state is SimsGetsSuccessfully) {
            sims.clear();
            sims.addAll(state.sims!);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: SafeArea(
                child: Scaffold(
              appBar: AppBar(
                title: Text(widget.message),
              ),
              body: ListView.builder(
                itemCount: sims.length,
                itemBuilder: (context, index) {
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
                              Text(
                                "${sims[index].series} - ${sims[index].no}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              (sims[index].discount != 0)
                                  ? Text(
                                      "${sims[index].discount} % OFF",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                                    )
                                  : const SizedBox(),
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
                                    "${sims[index].package!.sameNetworkMins}",
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
                                    "${sims[index].package!.otherNetworkMins}",
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
                                    "${sims[index].package!.data}",
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
                                      (sims[index].discount != 0)
                                          ? Text(
                                              "${sims[index].price} PKR",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                  fontSize: 16,
                                                  decoration: TextDecoration.lineThrough),
                                            )
                                          : Text(
                                              "${sims[index].price} PKR",
                                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16),
                                            ),
                                      (sims[index].discount != 0) ? Text(
                                        "${sims[index].discountPrice} PKR",
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
                                    "${sims[index].package!.messages}",
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "SMS",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          (sims[index].available == true)
                              ? ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                                  ),
                                  onPressed: () {
                                    Nav.push(context, SimDetailScreen(sims[index]));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(size.height * 0.012),
                                    child: Text(
                                      "Buy Now",
                                      style: TextStyle(fontSize: size.height * 0.025),
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                                  ),
                                  onPressed: () {},
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
                    ),
                  );
                },
              ),
            )),
          );
        },
      ),
    );
  }
}
