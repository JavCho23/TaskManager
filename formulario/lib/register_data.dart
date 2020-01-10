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
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final formKey = GlobalKey<FormState>();
  int breaksTotal, processesTotal;
  List<Widget> processesW = [];
  List<int> processes = [];
  List<int> breaks = [];

  // _MyRegisterPageState(this.breaksTotal, this.processesTotal) {
  //   for (var i = 0; i < processesTotal; i++) {
  //     processesW.add(Card(
  //         child: Row(
  //       children: <Widget>[
  //         Container(
  //           width: 300,
  //           child: Text(
  //             'P',
  //             style: TextStyle(
  //               fontSize: 22,
  //             ),
  //           ),
  //         ),
  //         TextFormField(
  //           decoration: InputDecoration(labelText: 'Cantidad de procesos'),
  //           keyboardType: TextInputType.number,
  //           validator: (input) =>
  //               input.length == 0 ? 'Ingrese un número correcto' : null,
  //           onSaved: (input) => processes[i] = int.parse(input),
  //         ),
  //         TextFormField(
  //           decoration:
  //               InputDecoration(labelText: 'Cantidad de interrupciones'),
  //           keyboardType: TextInputType.number,
  //           validator: (input) =>
  //               input.length == 0 ? 'Ingrese un número correcto' : null,
  //           onSaved: (input) => breaks[i] = int.parse(input),
  //         )
  //       ],
  //     )));
  //   }
  //}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: Text('Datos de los procesos'),
                  ),
                )
              ],
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
