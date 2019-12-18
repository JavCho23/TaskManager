import 'package:flutter/material.dart';
import './DataEstructurePage.dart';
import './GraphicPage.dart';
import './StatePage.dart';
import './TracePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pages = [DataStructurePage(), TracePage(), StatePage(), GraphicPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quantum'),
        ),
        body: _pages[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                title: Text('Estructura'),
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.blur_linear),
                title: Text('Trazas'),
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.data_usage),
                title: Text('Estados'),
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.assessment),
                title: Text('Histograma'),
                backgroundColor: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }
}
