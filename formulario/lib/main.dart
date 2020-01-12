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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TaskManager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  int breaks, processes, priorities;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            Card(
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
                            decoration: InputDecoration(
                                labelText: 'Cantidad de procesos'),
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
                            decoration: InputDecoration(
                                labelText: 'Cantidad de prioridades'),
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
