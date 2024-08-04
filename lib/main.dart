import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'featurs/cubit/game_cubit.dart';
import 'featurs/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit()..gameInitial(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: splashScreen(),
      ),
    );
  }
}
