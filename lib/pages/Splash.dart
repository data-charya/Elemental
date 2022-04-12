import 'package:elemental/pages/nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            height: 100,
            child: Text(
              'Elemental',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 400,
              width: 400,
              child: Lottie.asset("assets/ele.json"),
            ),
          ),
          SizedBox(
            width: 400,
            height: 100,
            child: Text(
              'Explore the elements in 3D',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
