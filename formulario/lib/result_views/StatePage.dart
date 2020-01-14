import 'package:flutter/material.dart';
import 'package:formulario/class/state.dart';

class StatePage extends StatefulWidget {
  List states = [];
  StatePage(this.states);
  @override
  State<StatefulWidget> createState() {
    return StatePageState(states);
  }
}

class StatePageState extends State<StatePage> {
  List states = [];
  StatePageState(this.states);
  TextStyle decotationText = TextStyle(fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 63,
                  child: Text(
                    'Proceso',
                    style: decotationText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 60,
                  child: Text(
                    'Av Inst.',
                    style: decotationText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  child: Text(
                    'Estado',
                    style: decotationText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      Divider(),
      ...states.map((element) {
        if (element is StateQ) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                if (element.state == 'E')
                  Divider(
                    thickness: 3.0,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 60,
                          child: Text(
                            'P' + element.id.toString(),
                            style: decotationText,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 60,
                          child: Text(
                            element.inst[0].toString() +
                                ' - ' +
                                element.inst[1].toString(),
                            style: decotationText,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 60,
                          child: Text(
                            element.state,
                            style: decotationText,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 325,
              child: Divider(
                thickness: 3.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  element.toString(),
                  style: decotationText,
                )
              ],
            )
          ],
        );
      }).toList(),
    ]);
  }
}
