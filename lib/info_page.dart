import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bilgi", textAlign: TextAlign.center),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Container(
            padding: new EdgeInsets.only(left: 40, top: 150),
            child: Text(
              "Mobil Programla Vize Projesi",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            padding: new EdgeInsets.only(left: 40, top: 60),
            child: Text(
              "Hazırlayan : Burak ÇETİNKAYA/18090700048",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
