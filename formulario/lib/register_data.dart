import 'package:flutter/material.dart';
import 'package:formulario/result_view.dart';
import 'package:formulario/class/interruption.dart';
import 'package:formulario/simulation.dart';
import 'class/structures.dart';
import 'class/process.dart';

class MyRegisterPage extends StatefulWidget {
  MyRegisterPage({Key key, this.title, this.interruptions, this.processes})
      : super(key: key);

  final String title;
  int processes;
  int interruptions;

  @override
  _MyRegisterPageState createState() =>
      _MyRegisterPageState(interruptions, processes);
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final formKey = GlobalKey<FormState>();
  int breaksTotal, processesTotal;
  List<Widget> processesW = [];
  List<int> processes = [];
  List<int> breaks = [];
  double maxFormFieldWidth = 70;
  _MyRegisterPageState(this.breaksTotal, this.processesTotal) {
    for (var i = 1; i <= processesTotal; i++) {
      processesW.add(
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Card(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'P$i',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: maxFormFieldWidth),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Llegada'),
                        keyboardType: TextInputType.number,
                        validator: (input) => input.length == 0
                            ? 'Ingrese un número correcto'
                            : null,
                        onSaved: (input) => processes[i] = int.parse(input),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: maxFormFieldWidth),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Tiempo'),
                        keyboardType: TextInputType.number,
                        validator: (input) => input.length == 0
                            ? 'Ingrese un número correcto'
                            : null,
                        onSaved: (input) => processes[i] = int.parse(input),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: maxFormFieldWidth),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Prioridad'),
                        keyboardType: TextInputType.number,
                        validator: (input) => input.length == 0
                            ? 'Ingrese un número correcto'
                            : null,
                        onSaved: (input) => processes[i] = int.parse(input),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ))
      ]));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  child: Text('Datos de los procesos'),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: processesW,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _submit,
                  child: Text(
                    'Calcular',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _submit() {
    // if (formKey.currentState.validate()) {
    // formKey.currentState.save();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ResultVieW(TaskManager(
          StructureStack([
            Process(1, 4, 4, 1, [Interruption(1, 3), Interruption(2, 7)]),
            Process(2, 6, 3, 3, [Interruption(1, 11), Interruption(2, 3)]),
            Process(3, 3, 4, 1, [Interruption(1, 3), Interruption(2, 11)]),
            Process(4, 2, 3, 2, [Interruption(1, 7), Interruption(2, 11)]),
            Process(5, 1, 5, 3, [Interruption(1, 3), Interruption(2, 15)])
          ]),
          StructurePriority([], [2, 1, 3]),
          StructureStack([]),
          StructureStack([]),
          4,
          [
            InterruptionConfig(1, 1, 0),
            InterruptionConfig(2, 1, 1),
          ]));
    }));
    // }
  }
}
