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
  int breaksTotal, processesTotal, priorities, _quantum;
  List<Structure> structure = [
    StructureQuewe([]),
    StructureQuewe([]),
    StructureQuewe([]),
    StructureQuewe([])
  ];

  List<List<int>> priorityOrder = [[], [], [], []];
  List<bool> priorityFLow = [true, true, true, true];
  List<bool> _visible = [false, false, false, false];
  List<String> typeStructure = ['Linea de espera', 'Pila', 'Prioridad'];
  List<String> typeStructureSelected = [
    'Linea de espera',
    'Linea de espera',
    'Linea de espera',
    'Linea de espera'
  ];

  List<Widget> processesW = [], breaksW = [];
  List<List<Widget>> priorityOrderW = [[], [], [], []];
  List<Process> processes = [];
  List<InterruptionConfig> breaks = [];

  double maxFormFieldWidth = 60;

  _MyRegisterPageState(this.breaksTotal, this.processesTotal, this.priorities) {
    bool sw = true;
    for (int i = 0; i < 4; i++) {
      for (var j = 0; j < priorities; j++) {
        priorityOrderW[i].add(Container(
          constraints: BoxConstraints(maxWidth: 60),
          child: TextFormField(
            initialValue: "0",
            decoration: InputDecoration(labelText: 'Prioridad'),
            keyboardType: TextInputType.number,
            onSaved: (input) => priorityOrder[i].add(int.parse(input)),
          ),
        ));
        priorityOrderW[i].add(Container(
          constraints: BoxConstraints(maxWidth: 100),
          child: Text('>'),
        ));
      }
      priorityOrderW[i].removeLast();
    }

    for (var i = 1; i <= processesTotal; i++) {
      processes.add(Process.empy(i));
      Process p = processes.last;
      List<Widget> interruptionW = [];
      List<Interruption> breaks = [];
      for (var i = 1; i <= breaksTotal; i++) {
        Interruption inte = Interruption.empy(i);
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
        breaks.add(inte);
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
                height: 100,
                width: 330,
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
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Column(
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
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          width: 330,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Duracion del Quantum'),
                              Container(
                                constraints: BoxConstraints(maxWidth: 100),
                                child: TextFormField(
                                  decoration: InputDecoration(hintText: '4'),
                                  keyboardType: TextInputType.number,
                                  validator: (input) => input.length == 0
                                      ? 'Ingrese un número correcto'
                                      : null,
                                  onSaved: (input) =>
                                      _quantum = int.parse(input),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              child: Text(
                                'Nuevo',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 60,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Container(
                                  //width: 350,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: DropdownButton(
                                      value: typeStructureSelected[0],
                                      onChanged: (String value) {
                                        _asingEstructure(value, 0);
                                      },
                                      items: typeStructure
                                          .map((item) => DropdownMenuItem(
                                                child: Text(item),
                                                value: item,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 400),
                                      opacity: _visible[0] ? 1.0 : 0.0,
                                      child: Row(
                                        children: <Widget>[
                                          ...priorityOrderW[0],
                                          Radio(
                                            groupValue: priorityFLow[0],
                                            value: true,
                                            onChanged: (bool value) {
                                              setState(() {
                                                priorityFLow[0] = value;
                                              });
                                            },
                                          ),
                                          Text('Mayor'),
                                          Radio(
                                            groupValue: priorityFLow[0],
                                            value: false,
                                            onChanged: (bool value) {
                                              setState(() {
                                                priorityFLow[0] = value;
                                              });
                                            },
                                          ),
                                          Text('Menor'),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              child: Text(
                                'Listo',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 60,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Container(
                                  //width: 350,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: DropdownButton(
                                      value: typeStructureSelected[1],
                                      onChanged: (String value) {
                                        _asingEstructure(value, 1);
                                      },
                                      items: typeStructure
                                          .map((item) => DropdownMenuItem(
                                                child: Text(item),
                                                value: item,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 400),
                                      opacity: _visible[1] ? 1.0 : 0.0,
                                      child: Row(
                                        children: <Widget>[
                                          ...priorityOrderW[1],
                                          Radio(
                                            groupValue: priorityFLow[1],
                                            value: true,
                                            onChanged: (bool value) {
                                              setState(() {
                                                priorityFLow[1] = value;
                                              });
                                            },
                                          ),
                                          Text('Mayor'),
                                          Radio(
                                            groupValue: priorityFLow[1],
                                            value: false,
                                            onChanged: (bool value) {
                                              setState(() {
                                                priorityFLow[1] = value;
                                              });
                                            },
                                          ),
                                          Text('Menor'),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              child: Text(
                                'Bloqueado',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 60,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Container(
                                  //width: 350,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: DropdownButton(
                                      value: typeStructureSelected[2],
                                      onChanged: (String value) {
                                        _asingEstructure(value, 2);
                                      },
                                      items: typeStructure
                                          .map((item) => DropdownMenuItem(
                                                child: Text(item),
                                                value: item,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 400),
                                      opacity: _visible[2] ? 1.0 : 0.0,
                                      child: Row(
                                        children: <Widget>[
                                          ...priorityOrderW[2],
                                          Radio(
                                            groupValue: priorityFLow[2],
                                            value: true,
                                            onChanged: (bool value) {
                                              setState(() {
                                                priorityFLow[2] = value;
                                              });
                                            },
                                          ),
                                          Text('Mayor'),
                                          Radio(
                                            groupValue: priorityFLow[2],
                                            value: false,
                                            onChanged: (bool value) {
                                              setState(() {
                                                priorityFLow[2] = value;
                                              });
                                            },
                                          ),
                                          Text('Menor'),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              child: Text(
                                'Suspendido',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 60,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Container(
                                  //width: 350,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: DropdownButton(
                                      value: typeStructureSelected[3],
                                      onChanged: (String value) {
                                        _asingEstructure(value, 3);
                                      },
                                      items: typeStructure
                                          .map((item) => DropdownMenuItem(
                                                child: Text(item),
                                                value: item,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 400),
                                      opacity: _visible[3] ? 1.0 : 0.0,
                                      child: Row(
                                        children: <Widget>[
                                          ...priorityOrderW[3],
                                          Radio(
                                            groupValue: priorityFLow[3],
                                            value: true,
                                            onChanged: (bool value) {
                                              setState(() {
                                                priorityFLow[3] = value;
                                              });
                                            },
                                          ),
                                          Text('Mayor'),
                                          Radio(
                                            groupValue: priorityFLow[3],
                                            value: false,
                                            onChanged: (bool value) {
                                              setState(() {
                                                priorityFLow[3] = value;
                                              });
                                            },
                                          ),
                                          Text('Menor'),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
            )
          ],
        ),
      ),
    );
  }

  void _asingEstructure(String type, int i) {
    bool sw = true;

    setState(() {
      if (type == 'Linea de espera') {
        sw = false;
        structure[i] = StructureQuewe([]);
      } else if (type == 'Pila') {
        sw = false;
        structure[i] = StructureStack([]);
      } else
        structure[i] = StructurePriority([], []);
      _visible[i] = sw;
      typeStructureSelected[i] = type;
    });
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      structure[0].data = processes
          .map((item) => Process(item.id, item.arrived, item.time,
              item.priority, item.interruptions))
          .toList();

      print(structure[0]);
      print(structure[1]);
      if (structure[0] is StructurePriority) {
        (structure[0] as StructurePriority).orden = priorityFLow[0]
            ? priorityOrder[0]
            : priorityOrder[0].reversed.toList();
      }
      if (structure[1] is StructurePriority) {
        (structure[1] as StructurePriority).orden = priorityFLow[1]
            ? priorityOrder[1]
            : priorityOrder[1].reversed.toList();
      }
      if (structure[2] is StructurePriority) {
        (structure[2] as StructurePriority).orden = priorityFLow[2]
            ? priorityOrder[2]
            : priorityOrder[2].reversed.toList();
      }
      if (structure[3] is StructurePriority) {
        (structure[3] as StructurePriority).orden = priorityFLow[3]
            ? priorityOrder[3]
            : priorityOrder[3].reversed.toList();
      }
      TaskManager tm = TaskManager(structure[0], structure[1], structure[2],
          structure[3], _quantum, breaks);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ResultVieW(tm);
      }));
    }
  }
}
