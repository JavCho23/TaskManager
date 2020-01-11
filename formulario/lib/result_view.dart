import 'package:flutter/material.dart';
import 'package:formulario/class/structures.dart';
import 'package:formulario/simulation.dart';
import 'result_views/DataEstructurePage.dart';
import 'result_views/GraphicPage.dart';
import 'result_views/StatePage.dart';
import 'result_views/TracePage.dart';

class ResultVieW extends StatefulWidget {
  // This widget is the root of your application.
  final TaskManager tm;
  ResultVieW(this.tm);
  @override
  State<StatefulWidget> createState() {
    return ResultVieWState(tm);
  }
}

class ResultVieWState extends State<ResultVieW> {
  int _selectedPage = 0;
  StatePage statePage;
  var _pages;
  ResultVieWState(TaskManager tm) {
    tm.calcular();
    _pages = [
      DataStructurePage(tm.ew.data, tm.ready.data, tm.executing.data,
          tm.bloked.data, tm.suspended.data, tm.terminated.data),
      TracePage(),
      StatePage(tm.states),
      GraphicPage(tm.executing.data)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskManager'),
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
              title: Text('Grafico'),
              backgroundColor: Theme.of(context).primaryColor)
        ],
      ),
    );
  }
}
