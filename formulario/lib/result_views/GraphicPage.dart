import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:formulario/class/process.dart';

class GraphicPage extends StatelessWidget {
  List<charts.Series<Process, int>> seriesList;
  final List<Process> executing;

  GraphicPage(this.executing) {
    var data = executing;
    seriesList = [
      charts.Series<Process, int>(
        id: 'Procesos',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Process process, _) => process.id,
        measureFn: (Process process, _) => executing.indexOf(process) + 1,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      seriesList,
      animate: true,
    );
  }
}
