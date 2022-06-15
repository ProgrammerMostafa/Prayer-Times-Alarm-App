import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/cubit.dart';
import '../bloc_observer.dart';
import '../layout/alarm_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //////////////////////////////////////////
  BlocOverrides.runZoned(
    () async {
      // Use cubits...
      /////////////////////
      await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      );
      /////////////////////
      runApp(
        BlocProvider<AlarmCubit>(
          create: (context) => AlarmCubit()..getPrayerTimesNow(),
          child: const MyApp(),
        ),
      );
      //////////////////////
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const AlarmLayout(),
    );
  }
}
