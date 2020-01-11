import 'package:flutter/material.dart';
import 'package:formulario/result_view.dart';
import 'package:formulario/class/interruption.dart';
import 'package:formulario/simulation.dart';
import 'class/structures.dart';
import 'class/process.dart';

class MyRegisterPage extends StatefulWidget {
  MyRegisterPage(
      {Key key,
      this.title,
      this.interruptions,
      this.processes,
      this.priorities})
      : super(key: key);

  final String title;
  int processes;
  int interruptions;
  int priorities;
  @override
  _MyRegisterPageState createState() =>
      _MyRegisterPageState(interruptions, processes, priorities);
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final formKey = GlobalKey<FormState>();
  int breaksTotal, processesTotal, priorities;
  List<Widget> processesW = [];
  List<Widget> breaksW = [];
  List<Process> processes = [];
  List<InterruptionConfig> breaks = [];
  double maxFormFieldWidth = 60;
  _MyRegisterPageState(this.breaksTotal, this.processesTotal, this.priorities) {
    for (var i = 1; i <= processesTotal; i++) {
      processes.add(Process.empy(i));
      Process p = processes.last;
      List<Widget> interruptionW = [];
      List<Interruption> breaks = [];
      for (var i = 1; i <= breaksTotal; i++) {
        Interruption inte = Interruption.empy(i);
        breaks.add(inte);
        interruptionW.add(Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: maxFormFieldWidth),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Int $i'),
              keyboardType: TextInputType.number,
              validator: (input) =>
                  input.length == 0 ? 'Ingrese un número correcto' : null,
              onSaved: (input) => inte.inst = int.parse(input) - 1,
            ),
          ),
        ));
      }
      p.interruptions = breaks;
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
              Container(
                height: 60,
                width: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: maxFormFieldWidth),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Llegada'),
                          keyboardType: TextInputType.number,
                          validator: (input) => input.length == 0
                              ? 'Ingrese un número correcto'
                              : null,
                          onSaved: (input) => p.arrived = int.parse(input),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: maxFormFieldWidth),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Tiempo'),
                          keyboardType: TextInputType.number,
                          validator: (input) => input.length == 0
                              ? 'Ingrese un número correcto'
                              : null,
                          onSaved: (input) => p.time = int.parse(input),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: maxFormFieldWidth),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Prioridad'),
                          keyboardType: TextInputType.number,
                          validator: (input) => input.length == 0
                              ? 'Ingrese un número correcto'
                              : null,
                          onSaved: (input) => p.priority = int.parse(input),
                        ),
                      ),
                    ),
                    ...interruptionW
                  ],
                ),
              )
            ],
          ),
        ))
      ]));
    }
    for (var i = 1; i <= breaksTotal; i++) {
      double maxFormFieldWidth = 150;

      InterruptionConfig ig = InterruptionConfig.empy(i);
      breaks.add(ig);
      breaksW.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    'Interrupcion $i',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: maxFormFieldWidth),
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Tiempo en MF'),
                            keyboardType: TextInputType.number,
                            validator: (input) => input.length == 0
                                ? 'Ingrese un número correcto'
                                : null,
                            onSaved: (input) => ig.blocked = int.parse(input),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: maxFormFieldWidth),
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Tiempo en DAS'),
                            keyboardType: TextInputType.number,
                            validator: (input) => input.length == 0
                                ? 'Ingrese un número correcto'
                                : null,
                            onSaved: (input) => ig.suspended = int.parse(input),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ));
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  child: Text('Datos de las interruptionces'),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: breaksW,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  child: Text('Orden de las estructuras'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: Text('Nuevo'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: Text('Listo'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: Text('Bloqueado'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: Text('Suspendido'),
                      ),
                    )
                  ],
                ),
              ),
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
