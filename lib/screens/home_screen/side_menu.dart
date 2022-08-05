import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sim_phone/screens/home_screen/order_screen/order_screen.dart';
import 'package:sim_phone/screens/profile_screen/profile_screen.dart';

import '../../bloc/drawer_cubit/drawer_cubit.dart';
import '../../models/api_response/get_user_api_response.dart';
import '../../ui_components/show_snack_bar.dart';
import '../../utils/api_constants/api_constants.dart';
import '../../utils/navigation_controller/navigator_screen.dart';
import '../get_started.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  GetUserApiResponse? userApiResponse;


  @override
  void initState() {
    context.read<DrawerCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<DrawerCubit, DrawerState>(
      listener: (context, state) {
        if (state is FailedToGetUser) {
          showSnackBar(context, state.message);
        }
        if (state is GetUserSuccessfully) {
          userApiResponse = state.userApiResponse;
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userApiResponse?.name ?? ""),
                  accountEmail: Text(
                    userApiResponse?.email ?? "",
                    style: const TextStyle(fontSize: 12),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                  ),
                  currentAccountPicture: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl: "${ApiConstants.baseUrl}${userApiResponse?.avatar ?? ""}",
                        fit: BoxFit.fill,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.person),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text("Profile"),
                        onTap: () {
                          Nav.push(context, const ProfileScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text("Setting"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.list),
                        title: const Text("Orders"),
                        onTap: () {
                          Nav.push(context, const OrderScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text("Logout"),
                        onTap: () {
                          GetStorage().write('token', null);
                          showSnackBar(context, "Logout Successfully", type: SnackBarType.success);
                          Nav.pushAndRemoveAllRoute(context, const GetStarted());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
