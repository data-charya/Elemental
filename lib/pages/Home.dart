import 'dart:convert';

import 'package:elemental/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List f = [];
var facts;
List fact = [];

class _HomePageState extends State<HomePage> {
  RandomColor _randomColor = RandomColor();
  getdata() async {
    String url = 'https://elementalapi.herokuapp.com/api/v2/';
    var data = await http.get(Uri.parse(url));

    facts = json.decode(data.body);
    if (f.length < 20) {
      for (var i = 0; i < 20; i++) {
        f.add(facts['Element_data'][i]['info']);
      }
      setState(() {
        fact = f.reversed.toList();
      });
    }
  }

  @override
  void initState() {
    getdata();
    print(f.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 50,
                  child: Text(
                    'Feeling curious ?',
                    style: GoogleFonts.nunito(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 580,
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: f.length,
                itemBuilder: (context, index) {
                  Color _color = _randomColor.randomColor(
                      colorHue: ColorHue.green,
                      colorBrightness: ColorBrightness.light);
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              f[index],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
