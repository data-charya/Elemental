import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

bool show = false;
bool found = true;

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = [];
  List filteredNames;
  List res = [];
  Icon _searchIcon = new Icon(Icons.search);

  _SearchPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

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
                      setState(() {
                        _getNames(_filter);
                        if (_filter.isEmpty) {
                          show = false;
                        } else {
                          show = true;
                        }
                      });
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
                      suffixIcon: show
                          ? IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  show = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {},
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
                child: show
                    ? found
                        ? _buildlist()
                        : Notfound()
                    : Center(
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
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _getNames(String name) async {
    String periodicUrl = "https://periodic-table-api.herokuapp.com/";
    var data = await http.get(Uri.parse(periodicUrl));
    var period;
    period = json.decode(data.body);
    setState(() {
      res = [];
      for (int i = 0; i < 118; i++) {
        var temp = period[i]['name'].toString();
        names.add(temp);
      }

      for (int i = 0; i < 118; i++) {
        String ele = '';
        ele = names[i];
        ele = ele.toLowerCase();
        if (ele.contains(name)) {
          setState(() {
            res.add(ele);
            found = true;
          });
        } else {
          setState(() {
            found = false;
          });
        }
      }
      if (found) {
        setState(() {
          show = true;
        });
      } else {
        setState(() {
          show = false;
        });
      }
    });
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

class Notfound extends StatelessWidget {
  const Notfound({
    Key key,
  }) : super(key: key);

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
