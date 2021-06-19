import 'package:elemental/pages/About.dart';
import 'package:elemental/pages/Home.dart';
import 'package:elemental/pages/Search.dart';
import 'package:elemental/pages/Table.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  Widget _child;

  @override
  void initState() {
    _child = HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _child,
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      bottomNavigationBar: FluidNavBar(
        animationFactor: 0.5,

        style: FluidNavBarStyle(
          barBackgroundColor: Colors.greenAccent,
          iconBackgroundColor: Colors.white54,
          iconSelectedForegroundColor: Colors.white,
          iconUnselectedForegroundColor: Color.fromRGBO(16, 16, 16, 1),
        ),

        icons: [
          FluidNavBarIcon(icon: Icons.home),
          FluidNavBarIcon(icon: Icons.search),
          FluidNavBarIcon(icon: Icons.tab),
          FluidNavBarIcon(icon: Icons.settings),
        ],
        onChange: _handleNavigationChange, // (4)
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomePage();
          break;
        case 1:
          _child = SearchPage();
          break;
        case 2:
          _child = TablePage();
          break;
        case 3:
          _child = About();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOutCirc,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
