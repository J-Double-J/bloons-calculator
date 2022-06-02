import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'monkeyTower.dart';
import 'APIService.dart';
import 'RoundConstants.dart';

//TODO: Provider
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloons Tower Price Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String findRoundInitVal(List<bool> diff) {
  String init = "1";

  for (int i = 0; i < diff.length; i++) {
    if (diff.elementAt(i)) {
      if (i >= 3) {
        init = "6";
        break;
      } else {
        init = (i + 1).toString();
        break;
      }
    }
  }
  return init;
}

Widget headNavBar(BuildContext context) {
  return Container(
    width: 0.9 * MediaQuery.of(context).size.width,
    height: 60,
    decoration: BoxDecoration(
        color: Colors.white24, borderRadius: BorderRadius.circular(20)),
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "Home",
          ),
        ),
        TextButton(
            onPressed: () {},
            child: const Text(
              "Another Option",
            ))
      ],
    ),
  );
}

Widget toolInfoCard(BuildContext context) {
  return Container(
    height: 300,
    width: 0.6 * MediaQuery.of(context).size.width,
    color: Theme.of(context).cardColor,
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Text(
        "Btd6 Round Cash and Tower Calculator",
        style: Theme.of(context).textTheme.headline4,
      ),
      const Text(
          "This calculator seeks to tell you how much cash you will have by a specific round. Using this information you can decide how you will spend your money on different towers."),
      Text(
        "Choose your difficulty and then the round number you are going to. Afterwards you can add specific towers and will track your cost. This calculator does not assume income.",
        style: Theme.of(context).textTheme.headline6,
      )
    ]),
  );
}

Widget monkeyListCard(BuildContext context) {
  final Future<List<MonkeyTower>> towers = APIService().getTowers();
  return FutureBuilder(
      future: towers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(children: [
            Container(
              height: 100,
              width: 0.85 * MediaQuery.of(context).size.width,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            Container(
                height: 100,
                width: 0.85 * MediaQuery.of(context).size.width,
                color: Theme.of(context).cardColor,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Add Monkey",
                      style: TextStyle(color: Colors.white),
                    )))
          ]);
        } else {
          return Container(height: 300, width: 300, color: Colors.red);
        }
      });
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> isDiffSelected = [false, false, true, false, false];
  int roundNum = 3;
  int cashAvailable = 650;

  final roundController = TextEditingController();
  final _roundFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    roundController.text = findRoundInitVal(isDiffSelected);
    super.initState();
  }

  @override
  void dispose() {
    roundController.dispose();
    super.dispose();
  }

  _updateCashAvailable() {
    setState(() {
      cashAvailable = RoundConstants.getMaxRoundCash(
          int.parse(findRoundInitVal(isDiffSelected)), roundNum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Center(child: headNavBar(context)),
        Center(child: toolInfoCard(context)),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: 0.08 * MediaQuery.of(context).size.width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: Form(
                      key: _roundFormKey,
                      child: TextFormField(
                        //key: _roundFormKey,
                        controller: roundController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(height: 0)),
                        validator: (value) {
                          if (int.parse(value!) <
                              int.parse(findRoundInitVal(isDiffSelected))) {
                            return "";
                          } else if (int.parse(value) > 100) {
                            return "";
                          } else if (value.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          if (_roundFormKey.currentState!.validate()) {
                            log("Called!");
                            setState(() {
                              roundNum = int.parse(value!);
                              _updateCashAvailable();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Text(
                    "Cash Available: $cashAvailable",
                    style: const TextStyle(fontSize: 20),
                  )
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: ToggleButtons(
                    isSelected: isDiffSelected,
                    children: const [
                      Padding(padding: EdgeInsets.all(8), child: Text("Easy")),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Normal"),
                      ),
                      Padding(padding: EdgeInsets.all(8), child: Text("Hard")),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Impoppable"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("CHIMPS"),
                      )
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < isDiffSelected.length; i++) {
                          isDiffSelected[i] = i == index;
                        }
                      });
                    },
                  ),
                )
              ],
            )),
        monkeyListCard(context),
      ],
    )));
  }
}
