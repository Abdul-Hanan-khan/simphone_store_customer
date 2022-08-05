import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sim_phone/bloc/drawer_cubit/drawer_cubit.dart';
import 'package:sim_phone/screens/splash.dart';

import 'bloc/all_devices_cubit/all_devices_cubit.dart';
import 'bloc/all_phones_cubit/all_phones_cubit.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllDevicesCubit(),
        ),
        BlocProvider(
          create: (context) => AllPhonesCubit(),
        ),
        BlocProvider(
          create: (context) => DrawerCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Sim & Phone store',
        theme: ThemeData(primarySwatch: Colors.blue, appBarTheme: AppBarTheme(centerTitle: true, color: Colors.green.shade400)),
        home: const SplashScreen(),
      ),
    );
  }
}
