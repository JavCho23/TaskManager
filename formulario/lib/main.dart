import 'package:flutter/material.dart';
import 'package:formulario/register_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskManager',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'TaskManager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  int breaks, processes, priorities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    child: Text(
                      'Ingresa el número de procesos e interrupciones que tendra la simulación',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Cantidad de procesos'),
                      keyboardType: TextInputType.number,
                      validator: (input) => input.length == 0
                          ? 'Ingrese un número correcto'
                          : null,
                      onSaved: (input) => processes = int.parse(input),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Cantidad de interrupciones'),
                      keyboardType: TextInputType.number,
                      validator: (input) => input.length == 0
                          ? 'Ingrese un número correcto'
                          : null,
                      onSaved: (input) => breaks = int.parse(input),
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Cantidad de prioridades'),
                      keyboardType: TextInputType.number,
                      validator: (input) => input.length == 0
                          ? 'Ingrese un número correcto'
                          : null,
                      onSaved: (input) => priorities = int.parse(input),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: _submit,
                            child: Text(
                              'ir a registrar datos',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MyRegisterPage(
          title: 'TaskManager',
          interruptions: breaks,
          processes: processes,
          priorities: priorities,
        );
      }));
    }
  }
}
