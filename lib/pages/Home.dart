import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var facts;
int aqi;
var aqiperc;
var _color;
var border;
var co, h, no2, so2;
var f;
var link;
var text;
bool aqistatus = false;
List factlist = [];
List linklist = [];
final len = ValueNotifier<int>(0);

class _HomePageState extends State<HomePage> {
  getfacts() async {
    String url = 'https://elementalapi.shanwillpinto.tech/facts';
    var info = await http.get(Uri.parse(url));

    f = json.decode(info.body);
    for (int i = 0; i < f.length; i++) {
      factlist.add(f[i]['fact']);
      linklist.add(f[i]['link']);
      factlist = factlist.reversed.toList();
      linklist = linklist.reversed.toList();
    }
    setState(() {
      len.value = f.length;
    });
  }

  getdata() async {
    String url =
        'https://elementalapi.shanwillpinto.tech/aqi';
    var data = await http.get(Uri.parse(url));

    facts = json.decode(data.body);
    setState(() {
      aqi = facts['data']['aqi'];
      aqiperc = aqi / 302;
      co = facts['data']['iaqi']['co']['v'];
      no2 = facts['data']['iaqi']['no2']['v'];
      so2 = facts['data']['iaqi']['so2']['v'];
      h = facts['data']['iaqi']['h']['v'].toStringAsPrecision(3);
    });
    if (aqi > 0 && aqi <= 50) {
      setState(() {
        _color = Color.fromRGBO(39, 174, 96, 1); //green
        border = Color.fromRGBO(51, 214, 120, 1);
        aqistatus = true;
      });
    } else if (aqi > 50 && aqi <= 100) {
      setState(() {
        _color = Color.fromRGBO(241, 196, 15, 1); //yellow
        border = Color.fromRGBO(240, 174, 7, 1);
        aqistatus = true;
      });
    } else if (aqi > 100 && aqi <= 150) {
      setState(() {
        _color = Color.fromRGBO(230, 126, 34, 1); //orange
        border = Color.fromRGBO(255, 121, 18, 1);
        aqistatus = true;
      });
    } else if (aqi > 150 && aqi <= 200) {
      setState(() {
        _color = Color.fromRGBO(229, 57, 53, 1); //red
        border = Color.fromRGBO(227, 32, 27, 1);
        aqistatus = true;
      });
    } else if (aqi > 200 && aqi <= 300) {
      setState(() {
        _color = Color.fromRGBO(187, 143, 206, 1); //purple
        border = Color.fromRGBO(172, 49, 224, 1);
        aqistatus = true;
      });
    } else {
      setState(() {
        _color = Color.fromRGBO(144, 12, 63, 1); //maroon
        border = Color.fromRGBO(171, 5, 69, 1);
        aqistatus = true;
      });
    }
  }

  @override
  void initState() {
    getdata();
    getfacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1),
      body: responsive.width > 760
          ? ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Feeling curious ?',
                              style: GoogleFonts.nunito(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              'Check out todays chemical presence in the air',
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: SizedBox(
                    width: responsive.width,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: 400,
                              height: 170,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Lottie.asset(
                                                  'assets/aqi.json'),
                                            ),
                                            Text(
                                              "AQI ",
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.nunito(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child:
                                              LiquidCircularProgressIndicator(
                                            value: aqiperc, // Defaults to 0.5.
                                            valueColor: AlwaysStoppedAnimation(
                                                _color), // Defaults to the current Theme's accentColor.
                                            backgroundColor: Colors.grey[
                                                850], // Defaults to the current Theme's backgroundColor.
                                            borderColor: aqistatus == true
                                                ? border
                                                : border = Color.fromRGBO(
                                                    39, 174, 96, 1),
                                            borderWidth: 5.0,
                                            direction: Axis
                                                .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                            center: Text(
                                              aqi.toString(),
                                              style: GoogleFonts.nunito(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            height: 170,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "$co" + ' m3',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'CO',
                                          style: GoogleFonts.nunito(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            height: 170,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "$h" + ' m3',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'H',
                                          style: GoogleFonts.nunito(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            height: 170,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "$no2" + ' m3',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'NO2',
                                          style: GoogleFonts.nunito(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            height: 170,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.tealAccent[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "$so2" + ' m3',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'SO2',
                                          style: GoogleFonts.nunito(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                  child: Text(
                    'Wanna know something cool ?',
                    style: GoogleFonts.nunito(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: len,
                        builder: (context, value, widget) {
                          if (len.value == 0) {
                            return Center(
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child:
                                            Lottie.asset('assets/loading.json'),
                                      ),
                                      Text(
                                        'Loading',
                                        style: GoogleFonts.nunito(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 30, left: 30, right: 30),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .35,
                                height: 600,
                                child: ListView.builder(
                                    itemCount: factlist.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: SizedBox(
                                          width: 300,
                                          height: 200,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: SizedBox(
                                                    width: 140,
                                                    child: Text(
                                                      factlist[index],
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: SizedBox(
                                                    width: 160,
                                                    height: 160,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color: Colors.blue,
                                                            width: 5),
                                                        color: Colors.black,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                          linklist[index],
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  ImageChunkEvent
                                                                      loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes
                                                                    : null,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        height: 400,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Check out this project on Github',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                height: 200,
                                child: Center(
                                  child: Lottie.asset('assets/git.json'),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return Colors.black54;
                                        return Colors.black;
                                        // Use the component's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () async {
                                    const url =
                                        "https://github.com/data-charya/Elemental";
                                    if (await canLaunch(url))
                                      await launch(url);
                                    else
                                      throw "Could not launch $url";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      'Github',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Feeling curious ?',
                              style: GoogleFonts.nunito(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              'Check out todays chemical presence in the air',
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Lottie.asset('assets/aqi.json'),
                                  ),
                                  Text(
                                    "AQI ",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: LiquidCircularProgressIndicator(
                                  value: aqiperc, // Defaults to 0.5.
                                  valueColor: AlwaysStoppedAnimation(
                                      _color), // Defaults to the current Theme's accentColor.
                                  backgroundColor: Colors.grey[
                                      850], // Defaults to the current Theme's backgroundColor.
                                  borderColor: aqistatus == true
                                      ? border
                                      : border = Color.fromRGBO(39, 174, 96, 1),
                                  borderWidth: 5.0,
                                  direction: Axis
                                      .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                  center: Text(
                                    aqi.toString(),
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$co" + ' m3',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'CO',
                                      style: GoogleFonts.nunito(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$h" + ' m3',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'H',
                                      style: GoogleFonts.nunito(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$no2" + ' m3',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'NO2',
                                      style: GoogleFonts.nunito(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.tealAccent[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$so2" + ' m3',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'SO2',
                                      style: GoogleFonts.nunito(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Wanna know something cool ?',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: len,
                  builder: (context, value, widget) {
                    if (len.value == 0) {
                      return Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Lottie.asset('assets/loading.json'),
                                ),
                                Text(
                                  'Loading',
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 600,
                          child: ListView.builder(
                              itemCount: factlist.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: SizedBox(
                                    width: 300,
                                    height: 200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: SizedBox(
                                              width: 140,
                                              child: Text(
                                                factlist[index],
                                                style: GoogleFonts.nunito(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: SizedBox(
                                              width: 160,
                                              height: 160,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Colors.blue,
                                                      width: 5),
                                                  color: Colors.black,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    linklist[index],
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
    );
  }
}
