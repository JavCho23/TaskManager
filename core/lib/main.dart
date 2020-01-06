import 'package:core/simulation.dart';
import 'package:flutter/material.dart';
import 'class/structures.dart';
import 'class/process.dart';

void main() {
  print("Hola, mundo");
  // Structure linea = StructureStack([
  //       Process(1, 4, 4, 1),
  //       Process(2, 0, 3, 2),
  //       Process(3, 5, 4, 3),
  //       Process(4, 2, 4, 1),
  //       Process(5, 3, 4, 2),
  //       Process(6, 1, 3, 3)
  //     ]);
  // linea.ordenar(linea.data, 0, linea.getLength() - 1);
  // for (var i = 0; i < linea.getLength(); i++) {
  //   print(linea.getNext());
  // }
  TaskManager tm = TaskManager(
      StructurePriority([
        Process(1, 4, 4, 1),
        Process(2, 0, 3, 2),
        Process(3, 5, 4, 3),
        Process(4, 2, 4, 1),
        Process(5, 3, 4, 2),
        Process(6, 1, 3, 3)
      ],[1,3,2]),
      StructureStack([]),
      StructureQuewe([]),
      StructureQuewe([]),
      4);
  tm.calcular();
}
