import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sim_phone/ui_components/loading_screen_animation.dart';
import 'package:sim_phone/utils/api_constants/api_constants.dart';

import '../../bloc/drawer_cubit/drawer_cubit.dart';
import '../../models/api_response/get_user_api_response.dart';
import '../../ui_components/show_snack_bar.dart';
import '../../utils/navigation_controller/navigator_screen.dart';
import 'edit_profile_screen/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<DrawerCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetUserApiResponse? userApiResponse;

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
        return LoadingScreenAnimation(
          isLoading: state is LoadingState,
          child: SafeArea(
              child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: state is LoadingState
                  ? const SizedBox()
                  : ListView(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: "${ApiConstants.baseUrl}${userApiResponse?.avatar}",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                )),
                            IconButton(
                                onPressed: () {
                                  Nav.push(context, EditProfileScreen(userApiResponse));
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(userApiResponse?.name ?? ""),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(userApiResponse?.email ?? ""),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Phone",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("${userApiResponse?.phone}"),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("CNIC",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("${userApiResponse?.cnic}"),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Address",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 50,
                            ),
                            Expanded(
                                child: Text(
                              userApiResponse?.area ?? "",
                              maxLines: 5,
                            )),
                          ],
                        ),
                      ],
                    ),
            ),
          )),
        );
      },
    );
  }
}
