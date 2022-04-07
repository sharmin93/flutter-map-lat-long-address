import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'check_post.dart';
import 'controller/location_controller.dart';
import 'controller/map_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => LocationController(),
    ),
    ChangeNotifierProvider(
      create: (_) => MapController(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CheckPost(title: 'Flutter Demo Home Page'),
    );
  }
}
