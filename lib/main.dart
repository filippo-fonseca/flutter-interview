import 'dart:math';

import 'package:flutter/material.dart';
import "dart:async";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> entries = <dynamic>[];

  Color getRandomColor() {
    final List<Color> colorCodes = [
      Color(0xff30D5C8),
      Colors.blue,
      Colors.purple
    ];
    final _random = new Random();
    var element = colorCodes[_random.nextInt(colorCodes.length)];

    return element;
  }

  final String title = "";

  Future<http.Response> fetchAlbum() async {
    final response = await http.get('https://pokeapi.co/api/v2/gender/3/');
    if (response.statusCode == 200) {
      setState(() {
        entries = jsonDecode(response.body)["pokemon_species_details"];
      });

      print(entries);
    } else {
      print("Trash, didn't work");
    }
  }

  _launchURL(u) async {
    String url = u;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("TRASH");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pokedex"),
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: getRandomColor(),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _launchURL("google.com");
                      },
                      child: Text(
                        entries[index]["pokemon_species"]["name"].toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
