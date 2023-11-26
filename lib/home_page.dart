// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:function_tree/function_tree.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var tela = [];
  var result = [];

  var historyTela = [];
  var historyResult = [];

  final numeros = [
    ".",
    "0",
    "=",
    "+",
    "1",
    "2",
    "3",
    "-",
    "4",
    "5",
    "6",
    "×",
    "7",
    "8",
    "9",
    "÷"
  ];

  String calcula() {
    try {
      List ajustada = tela.join().split("");

      for (int i = 0; i < ajustada.length; i++) {
        if (ajustada[i] == "×") {
          ajustada[i] = "*";
        }
        if (ajustada[i] == "÷") {
          ajustada[i] = "/";
        }
      }

      RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
      String telaAjustada = ajustada.join();

      return telaAjustada.interpret().toString().replaceAll(regex, "");
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.history,
              ),
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),
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
                "Calculator",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700]),
              )),
            ),
          ),
          drawer: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20))),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 93, 88, 197),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      height: 150,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "History",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  HapticFeedback.vibrate();
                                  setState(() {
                                    historyTela = [];
                                    historyResult = [];
                                    scaffoldKey.currentState?.closeDrawer();
                                  });
                                },
                                icon: Icon(Icons.delete_outline),
                                iconSize: 25,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: historyTela.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              splashColor: Colors.blue[100],
                              tileColor: Colors.blue[50],
                              title: Text(historyTela[index]),
                              subtitle: Text("= ${historyResult[index]}"),
                              onTap: () {
                                HapticFeedback.vibrate();
                                setState(() {
                                  tela = [];
                                  result = [];
                                  for (int i = 0;
                                      i < historyTela[index].toString().length;
                                      i++) {
                                    tela.add(historyTela[index]
                                        .toString()
                                        .split("")[i]);
                                  }
                                  scaffoldKey.currentState?.closeDrawer();
                                });
                              },
                              onLongPress: () {
                                HapticFeedback.vibrate();
                                setState(() {
                                  historyTela.removeAt(index);
                                  historyResult.removeAt(index);
                                });
                              },
                            ),
                          );
                        })),
              ],
            ),
          ),
          body: Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                Expanded(
                  // Tela
                  child: Container(
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                            child: GestureDetector(
                              child: Text(
                                tela.join(),
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 30,
                                    color: Colors.grey.shade600),
                              ),
                              onLongPress: () {
                                Clipboard.setData(
                                    ClipboardData(text: calcula()));
                              },
                            ),
                          ),
                        ]),
                  ),
                ),
                SingleChildScrollView(
                  // Tela do resultado
                  scrollDirection: Axis.horizontal,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        child: Text(
                          calcula(),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 50,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w700),
                        ),
                        onLongPress: () {
                          HapticFeedback.vibrate();
                          Clipboard.setData(ClipboardData(text: calcula()));
                        },
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  // Teclado numérico
                  flex: 7,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            // teclado de cima
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue[200],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    height: 60,
                                    width: 60,
                                    child: TextButton(
                                      child: Text(
                                        "+/-",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        HapticFeedback.vibrate();
                                        if (tela.isNotEmpty) {
                                          if (tela[0] != "-") {
                                            setState(() {
                                              tela.insert(0, "-");
                                            });
                                          } else {
                                            setState(() {
                                              tela.removeAt(0);
                                            });
                                          }
                                        }
                                      },
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 93, 88, 197),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: TextButton(
                                        onPressed: () {
                                          HapticFeedback.vibrate();
                                          if (tela.length < 14) {
                                            setState(() {
                                              tela.add("(");
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 4, 0),
                                          child: Text(
                                            "(",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 20),
                                          ),
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.orange.shade800,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: TextButton(
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.white70),
                                        ),
                                        onPressed: () {
                                          HapticFeedback.vibrate();
                                          setState(() {
                                            tela = [];
                                            result = [];
                                          });
                                        },
                                        child: Text(
                                          "C",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontSize: 25),
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 93, 88, 197),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: TextButton(
                                        onPressed: () {
                                          HapticFeedback.vibrate();
                                          if (tela.length < 14) {
                                            setState(() {
                                              tela.add(")");
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              4, 0, 0, 0),
                                          child: Text(
                                            ")",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 20),
                                          ),
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.pink.shade200,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: IconButton(
                                    style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.pink),
                                    ),
                                    onPressed: () {
                                      HapticFeedback.vibrate();
                                      if (tela.isNotEmpty) {
                                        setState(() {
                                          tela.removeLast();
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.backspace_outlined,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GridView.builder(
                                reverse: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 16,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        crossAxisCount: 4),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:
                                            Color.fromARGB(255, 93, 88, 197)),
                                    height: 50,
                                    width: 50,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Colors.white12),
                                      ),
                                      child: Text(
                                        numeros[index],
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                            fontSize: 40),
                                      ),
                                      onPressed: () {
                                        HapticFeedback.vibrate();
                                        if (numeros[index] != "=") {
                                          if (tela.length < 14) {
                                            setState(() {
                                              tela.add(numeros[index]);
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            if (tela.join().toString() !=
                                                    calcula() &&
                                                calcula() != "") {
                                              historyTela.insert(
                                                  0, tela.join().toString());
                                              historyResult.insert(
                                                  0, calcula());
                                            }
                                            if (calcula() != "") {
                                              tela = calcula().split("");
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
