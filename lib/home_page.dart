import 'dart:async';

import 'package:flip_card/flip_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobil_programlama_vize_proje/info_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> cevirkart = [
    true, //kartların  durumunu belirtir
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  List<String> kartlar = [
    "1", //kartların bulunduğu kısım
    "1",
    "2",
    "2",
    "3",
    "3",
    "4",
    "4",
    "5",
    "5",
    "6",
    "6"
  ];
  int onceki = -1;
  bool flip = false;
  //kartların istenildiği zaman flip edicek
  List<GlobalKey<FlipCardState>> cardStateKey = [
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
  ];

  int time = 120;
  Timer timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time - 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    kartlar.shuffle(); // listedeki verileri karıştırır.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Memory Game"),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.info),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InfoPage(),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(6.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: kartlar.length,
                itemBuilder: (context, index) => FlipCard(
                  key: cardStateKey[index],
                  onFlip: () {
                    if (!flip) {
                      flip = true;
                      onceki = index;
                    } else {
                      flip = false;
                      if (onceki != index) {
                        if (kartlar[onceki] != kartlar[index]) {
                          cardStateKey[onceki].currentState.toggleCard();
                          onceki = index;
                        } else {
                          cevirkart[onceki] = false;
                          cevirkart[index] = false;
                          print(cevirkart);

                          if (cevirkart.every((t) => t == false)) {
                            sonuc();
                            timer.cancel();
                          }
                        }
                      }
                    }
                  },
                  direction: FlipDirection
                      .HORIZONTAL, // kartlara tıklandığında flip etmesi için
                  flipOnTouch: true,
                  front: Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: new BoxDecoration(
                        color: Colors.redAccent,
                        border: Border.all(width: 1, color: Colors.red),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(80))),
                    margin: EdgeInsets.all(4.0),
                  ),
                  back: Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: new BoxDecoration(
                        border: Border.all(width: 1, color: Colors.red),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(80))),
                    margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Center(
                      child: Text(
                        "${kartlar[index]}",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 200,
              height: 100,
              child: RaisedButton(
                color: Colors.redAccent,
                highlightColor: Colors.red,
                child: Text(
                  "Restart",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: new Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Kalan Süre : $time",
                      style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                          fontSize: 50),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  sonuc() {
    // sonucu ekrana yazdır
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          "Tebrikler",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.redAccent,
        content: Text("Süreniz : $time",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontStyle: FontStyle.italic,
            )),
        actions: <Widget>[
          FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text("Tekrar Deneyin",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
