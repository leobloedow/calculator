// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class Chess extends StatefulWidget {
  const Chess({super.key});

  @override
  State<Chess> createState() => _ChessState();
}

var num = 0;
var pieces = [
  "BRa",
  "BNb",
  "BBc",
  "BQd",
  "BKe",
  "BBf",
  "BNg",
  "BRh",
  "BPa",
  "BPb",
  "BPc",
  "BPd",
  "BPe",
  "BPf",
  "BPg",
  "BPh",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "WPa",
  "WPb",
  "WPc",
  "WPd",
  "WPe",
  "WPf",
  "WPg",
  "WPh",
  "WRa",
  "WNb",
  "WBc",
  "WQd",
  "WKe",
  "WBf",
  "WNg",
  "WRh",
];

var letras = ["a", "b", "c", "d", "e", "f", "g", "h"];

Widget letters(index) {
  if (index <= 7) {
    if (index % 2 == 0) {
      return Text(letras[index], style: TextStyle(color: Colors.white54));
    } else {
      return Text(letras[index], style: TextStyle(color: Colors.black54));
    }
  } else {
    return Text("");
  }
}

Widget numbers(index) {
  if (index % 8 == 0) {
    if ((index / 8 + 1) % 2 != 0) {
      return Text(
        (index / 8 + 1).round().toString(),
        style: TextStyle(color: Colors.white54),
      );
    } else {
      return Text((index / 8 + 1).round().toString(),
          style: TextStyle(color: Colors.black54));
    }
  } else {
    return Text("");
  }
}

Widget chessPiece(index) {
  if (index % 8 == 0) {
    num += 2;
  } else {
    num++;
  }
  if (num % 2 == 0) {
    return Center(
      child: Text(pieces[index]),
    );
  } else {
    return Center(
      child: Text(
        pieces[index],
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

Widget chessTile(index) {
  if (index % 8 == 0) {
    num += 2;
  } else {
    num++;
  }

  if (num % 2 == 0) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      height: 50,
      width: 50,
    );
  } else {
    return Container(
      decoration: BoxDecoration(color: Colors.black87),
      height: 50,
      width: 50,
    );
  }
}

class _ChessState extends State<Chess> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey[200]),
              child: Center(
                  child: Text(
                "Chess",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
              )),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Stack(children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 64,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) {
                    return chessTile(index);
                  }),
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 64,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) {
                    return chessPiece(index);
                  }),
              GridView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 64,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                      child: numbers(index),
                    );
                  }),
              GridView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 64,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                        child: letters(index),
                      ),
                    );
                  }),
            ]),
          ),
        ));
  }
}
