import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/presentation/screens/home_screen.dart';

import 'core/injectable/injectable.dart';

void main() {
  configureDependencies(GetIt.I);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
