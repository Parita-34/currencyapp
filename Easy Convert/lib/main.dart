import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_currency_converter/Currency.dart';
import 'package:flutter_currency_converter/flutter_currency_converter.dart';

void main() {
  runApp(MaterialApp(
    home: ExpHome(),
    debugShowCheckedModeBanner: false,
  ));
}

class ExpHome extends StatefulWidget {
  @override
  _ExpHomeState createState() => _ExpHomeState();
}

class _ExpHomeState extends State<ExpHome> {
  String cad_inr = "";
  //String dropDown;
  String _selected;
  List<Map> _myJson = [
    {'image': 'lib/images/us.png', 'name': 'USD', 'title': 'USA Dollars'},
    {'image': 'lib/images/cad.jpg', 'name': 'CAD', 'title': 'CAD Dollars'},
    {'image': 'lib/images/euro.png', 'name': 'EUR', 'title': 'EUR Euro'},
    {'image': 'lib/images/nz.png', 'name': 'NZD', 'title': 'NZD Dollars'}
  ];

  final cad_inrCon = new TextEditingController();

  String titleCalling() {
    final titleKey =
        _myJson.where((element) => element['name'] == _selected).toList();
    return titleKey[0]['title'];
  }

  void getAmounts(String val) async {
    double cad_inr_ = await FlutterCurrencyConverter.convert(
        Currency(val, amount: double.parse(cad_inrCon.text)),
        Currency(Currency.INR));

    setState(() {
      cad_inr = cad_inr_.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#6E92CF'),
      appBar: AppBar(
        title: Text('Easy calculate'),
        centerTitle: true,
        backgroundColor: HexColor('#6E92CF'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/bgg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 89),
                    child: Center(
                      child: Text(
                        'Currency Converter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        value: _selected,
                        hint: Text(
                          'Choose Currency',
                          style: TextStyle(
                            color: HexColor('#6E92CF'),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // icon: Icon(Icons.arrow_downward),
                        // iconSize: 34,
                        elevation: 16,
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 25),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (String newValue) {
                          setState(() {
                            _selected = newValue;
                          });
                        },
                        items: _myJson.map((cadItem) {
                          return DropdownMenuItem(
                              value: cadItem['name'].toString(),
                              child: Row(
                                children: [
                                  Image.asset(
                                    cadItem['image'],
                                    width: 25,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(cadItem['name']),
                                  )
                                ],
                              ));
                        }).toList(),
                        dropdownColor: Colors.indigo[100],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                          color: HexColor('#6E92CF').withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 20),
                            border: InputBorder.none,
                            hintText: _selected == null
                                ? 'Select Currency'
                                : 'Enter ${titleCalling()}',
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: HexColor('#6E92CF'),
                            ),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: Icon(
                                Icons.monetization_on_sharp,
                                size: 30,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: HexColor('#6E92CF'),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          controller: cad_inrCon,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 40, right: 40),
                      decoration: BoxDecoration(
                        color: HexColor('#6E92CF'),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: FlatButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Convert to INR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            getAmounts(_selected.toString());
                            cad_inrCon.clear();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 54,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor('#74B999'),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: FittedBox(
                                child: Text(
                                  'Rs $cad_inr',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
