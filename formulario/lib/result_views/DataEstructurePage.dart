import 'package:flutter/material.dart';
import 'package:formulario/class/process.dart';

class DataStructurePage extends StatefulWidget {
  List<Process> ew;
  List<Process> ready;
  List<Process> blocked;
  List<Process> suspended;
  List<Process> terminated;
  DataStructurePage(
      this.ew, this.ready, this.blocked, this.suspended, this.terminated);
  @override
  State<StatefulWidget> createState() {
    return DataStructureState(
        this.ew, this.ready, this.blocked, this.suspended, this.terminated);
  }
}

class DataStructureState extends State<DataStructurePage> {
  List<Process> ew;
  List<Process> ready;
  List<Process> blocked;
  List<Process> suspended;
  List<Process> terminated;
  DataStructureState(
      this.ew, this.ready, this.blocked, this.suspended, this.terminated);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Estructura'),
    );
  }
}
