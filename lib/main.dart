import 'package:elemental/Components/scroll_behaviour.dart';
import 'package:elemental/pages/Splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elemental 3D',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Splash(),
      scrollBehavior: ScrollWithoutMaterialOverflowGlow(),
    );
  }
}
