import 'package:elemental/Components/Data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_cube/flutter_cube.dart';

class ElementPage extends StatefulWidget {
  final int atomicnum;
  const ElementPage({Key key, @required this.atomicnum}) : super(key: key);

  @override
  _ElementPageState createState() => _ElementPageState();
}

var number;

class _ElementPageState extends State<ElementPage> {
  @override
  Widget build(BuildContext context) {
    Period p = new Period();

    var data = p.period;
    setState(() {
      number = widget.atomicnum.toInt();
    });

    var mass = data[widget.atomicnum]['atomicMass'].toString();
    mass = mass.substring(0, 3);

    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white60,
                    size: 30,
                  ),
                ),
                Text(
                  data[widget.atomicnum]['name'],
                  style: GoogleFonts.nunito(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Sideinfo(
                        data: data, atomicnum: widget.atomicnum, mass: mass)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Center(
                        child: Viewer(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 600,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Sideinfo extends StatelessWidget {
  const Sideinfo({
    Key key,
    @required this.data,
    @required this.atomicnum,
    @required this.mass,
  }) : super(key: key);

  final List data;
  final int atomicnum;
  final String mass;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 600,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              data[atomicnum]['symbol'],
                              style: GoogleFonts.nunito(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Atomic Symbol',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              mass,
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Atomic Mass',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              data[atomicnum]['electronegativity'],
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Electronegativity',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              data[atomicnum]['yearDiscovered'],
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Year Discovered',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Viewer extends StatefulWidget {
  var nu;
  @override
  _ViewerState createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  Object cube;
  String symbol;
  @override
  void initState() {
    Period p = new Period();
    var d = p.period;
    String symbol;

    setState(() {
      if (d[number]['symbol'] == 'Ar' ||
          d[number]['symbol'] == 'Ne' ||
          d[number]['symbol'] == 'He' ||
          d[number]['symbol'] == 'Kr' ||
          d[number]['symbol'] == 'Xe' ||
          d[number]['symbol'] == 'Rn' ||
          d[number]['symbol'] == 'Og') {
        symbol = 'H';
      } else {
        symbol = d[number]['symbol'].toString();
      }
    });
    print(number);
    cube = Object(fileName: "assets/Models/${symbol}.obj");
    cube.rotation.setValues(-30, -120, 40);
    cube.updateTransform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Container(
        child: Cube(
          onSceneCreated: (Scene scene) {
            scene.world.add(cube);
            scene.camera.zoom = 8;
          },
        ),
      ),
    );
  }
}
