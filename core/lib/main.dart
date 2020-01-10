import 'package:core/class/interruption.dart';
import 'package:core/simulation.dart';
import 'package:flutter/material.dart';
import 'class/structures.dart';
import 'class/process.dart';

void main() {
  TaskManager tm = TaskManager(
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
      ]);
  tm.calcular();
}
