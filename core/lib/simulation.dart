import 'package:core/class/process.dart';

import 'class/structures.dart';

class TaskManager {
  Structure ew;
  Structure ready;
  Structure executing;
  Structure terminated;
  int quantum;

  TaskManager(
      this.ew, this.ready, this.executing, this.terminated, this.quantum);

  void calcular() {
    ew.ordenar(ew.data, 0, ew.getLength() - 1);
    print('Nuevo');

    for (int i = 0; i < ew.getLength(); i++) {
      ready.add(ew.getNext());
      print(ew.data.elementAt(i));
    }
    print('Listo');

    for (int i = 0; i < ready.getLength(); i++) {
      print(ready.data.elementAt(i));
    }
    print('Estados');

    while (terminated.getLength() != ew.getLength()) {
      Process aux = ready.getNext();
      print(aux);

      executing.add(aux);
      aux.time = aux.time - 1;

      (aux.time <= 0) ? terminated.add(aux) : ready.add(aux);
    }
  }
}
