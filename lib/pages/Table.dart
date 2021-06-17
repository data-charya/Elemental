import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

List period;
bool isloading = true;

class _TablePageState extends State<TablePage> {
  getData() async {
    String periodicUrl = "https://periodic-table-api.herokuapp.com/";
    var data = await http.get(Uri.parse(periodicUrl));

    period = json.decode(data.body);
    return period;
  }

  @override
  void initState() {
    setState(() {
      getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (period == null) {
        isloading = true;
      } else {
        isloading = false;
      }
    });
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1),
      body: period == null ? Loaderbox() : Elements(),
    );
  }
}

class Elements extends StatefulWidget {
  @override
  _ElementsState createState() => _ElementsState();
}

class _ElementsState extends State<Elements> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(24, 24, 24, 1),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    key: UniqueKey(),
                    children: List.generate(
                      118,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              print(index + 1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(250, 184, 178, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          period[index]['atomicNumber'],
                                          style: GoogleFonts.nunito(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          period[index]['symbol'],
                                          style: GoogleFonts.nunito(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        period[index]['name'],
                                        style: GoogleFonts.nunito(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Loaderbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/loader.gif'),
            Text(
              'Processing reaction ...',
              style: GoogleFonts.nunito(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Loaded extends StatefulWidget {
  @override
  _LoadedState createState() => _LoadedState();
}

class _LoadedState extends State<Loaded> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (period == null) {
        return Loaderbox();
      } else {
        return Elements();
      }
    });
    return Elements();
  }
}
