import 'package:core/class/interruption.dart';
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
      StructureQuewe([
        Process(
          1,
          5,
          4,
          2,
          [Interruption(1, 3), Interruption(2, 7), Interruption(3, 11)],
        ),
        Process(
          2,
          3,
          5,
          3,
          [Interruption(1, 11), Interruption(2, 3), Interruption(3, 7)],
        ),
        Process(
          3,
          1,
          4,
          1,
          [Interruption(1, 15), Interruption(2, 7), Interruption(3, 3)],
        ),
        Process(4, 2, 4, 3, [Interruption(1, 3), Interruption(2, 11)]),
        Process(5, 9, 3, 2, [Interruption(1, 11), Interruption(3, 3)]),
        Process(6, 0, 5, 1,
            [Interruption(1, 15), Interruption(2, 3), Interruption(3, 7)])
      ]),
      StructurePriority([], [3, 1, 2]),
      StructureQuewe([]),
      StructureQuewe([]),
      StructureStack([]),
      StructureStack([]),
      4,
      [
        InterruptionConfig(1, 2, 0),
        InterruptionConfig(2, 1, 1),
        InterruptionConfig(3, 2, 2)
      ]);
  tm.calcular();
}
