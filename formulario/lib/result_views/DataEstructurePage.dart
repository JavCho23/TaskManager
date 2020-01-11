import 'package:flutter/material.dart';
import 'package:formulario/class/process.dart';

class DataStructurePage extends StatefulWidget {
  List<Process> ew;
  List<Process> ready;
  List<Process> executing;
  List<Process> blocked;
  List<Process> suspended;
  List<Process> terminated;
  DataStructurePage(this.ew, this.ready, this.executing, this.blocked,
      this.suspended, this.terminated);
  @override
  State<StatefulWidget> createState() {
    return DataStructureState(this.ew, this.ready, this.executing, this.blocked,
        this.suspended, this.terminated);
  }
}

class DataStructureState extends State<DataStructurePage> {
  List<Process> ew;
  List<Process> ready;
  List<Process> executing;
  List<Process> blocked;
  List<Process> suspended;
  List<Process> terminated;
  TextStyle decotationText = TextStyle(fontSize: 20);

  DataStructureState(this.ew, this.ready, this.executing, this.blocked,
      this.suspended, this.terminated);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Nuevo',
                style: decotationText,
              ),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: ew
                    .map((item) => Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Text(
                                  'P' + item.id.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Listo',
                style: decotationText,
              ),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: ready
                    .map((item) => Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Text(
                                  'P' + item.id.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Ejecutado',
                style: decotationText,
              ),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: executing
                    .map((item) => Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Text(
                                  'P' + item.id.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Bloqueado',
                style: decotationText,
              ),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: blocked
                    .map((item) => Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Text(
                                  'P' + item.id.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Suspendido',
                style: decotationText,
              ),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: suspended
                    .map((item) => Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Text(
                                  'P' + item.id.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Terminado',
                style: decotationText,
              ),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: terminated
                    .map((item) => Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Text(
                                  'P' + item.id.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ))
      ],
    );
  }
}
