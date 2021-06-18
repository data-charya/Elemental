import 'dart:convert';

import 'package:elemental/Components/Data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

bool show = false;
bool showbutton = false;
bool found = false;

class _SearchPageState extends State<SearchPage> {
  TextEditingController _filter = new TextEditingController();
  List names = [];
  List filteredNames;
  List res = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, left: 20, right: 30),
                  child: TextField(
                    onChanged: (_filter) {
                      if (_filter.isEmpty) {
                        setState(() {
                          showbutton = false;
                        });
                      } else {
                        setState(() {
                          showbutton = true;
                          _getNames(_filter);
                        });
                      }
                    },
                    controller: _filter,
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black45),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Search element ..',
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      suffixIcon: showbutton == false
                          ? Icon(Icons.search)
                          : IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  showbutton = false;
                                  show = false;
                                  found = false;
                                });
                              },
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.4,
                child: showscreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _getNames(String name) async {
    int check = 0;
    if (name.length == 0) {
      setState(() {
        show = false;
      });
    } else {
      Period period = new Period();
      var data = period.period;
      setState(() {
        res = [];
        for (int i = 0; i < 118; i++) {
          var temp = data[i]['name'].toString();
          names.add(temp);
        }
      });
      for (int i = 0; i < 118; i++) {
        String ele = '';
        ele = names[i];
        ele = ele.toLowerCase();

        if (ele.contains(name)) {
          setState(() {
            res.add(ele);
            print(res);
            check = 1;
          });
        }
      }
      print(check);
      if (check == 1) {
        setState(() {
          show = true;
          found = true;
          print('im here!');
        });
      } else {
        setState(() {
          found = false;
          print('im here too!');
        });
      }
    }
  }

  Widget showscreen() {
    Widget out;
    if (show == true && found == true) {
      out = _buildlist();
    } else if (show == false && found == false) {
      out = Search_something();
    } else {
      out = Notfound();
    }
    return out;
  }

  Widget _buildlist() {
    return ListView.builder(
      key: UniqueKey(),
      itemCount: res.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GestureDetector(
            onTap: () {
              print(res[index]);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  res[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Search_something extends StatelessWidget {
  const Search_something({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: Lottie.asset('assets/search.json'),
          ),
          Text(
            'Search something...',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

class Notfound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: Lottie.asset('assets/notfound.json'),
          ),
          Text(
            'Not Found',
            style: GoogleFonts.nunito(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
