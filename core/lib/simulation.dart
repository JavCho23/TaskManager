import 'package:core/class/interruption.dart';
import 'package:core/class/process.dart';
import 'class/state.dart';
import 'class/structures.dart';

class TaskManager {
  Structure ew;
  Structure ready;
  Structure executing;
  Structure terminated;
  Structure bloked;
  Structure suspended;
  List<State> states = [];
  List<InterruptionConfig> interruptions;
  int quantum;

  TaskManager(this.ew, this.ready, this.executing, this.terminated, this.bloked,
      this.suspended, this.quantum, this.interruptions);

  void calcular() {
    ew.ordenar(ew.data, 0, ew.getLength() - 1);

    for (int i = 0; i < ew.getLength(); i++) {
      ready.add(ew.getNext());
      states.add(State(ew.data.elementAt(i).id,
          [0, quantum * ew.data.elementAt(i).time], "N"));
      print(states.elementAt(i));
    }

    for (int i = 0; i < ready.getLength(); i++) {
      states.add(State(ready.data.elementAt(i).id,
          [0, quantum * ready.data.elementAt(i).time], "L"));
      print(states.last);
    }

    while (terminated.getLength() != ew.getLength()) {
      Process aux = ready.getNext();
      if (aux != null) {
        executing.add(aux);
        int inst = (aux.time - aux.timeLeft) * quantum;
        states.add(State(aux.id, [inst, inst + quantum - 1], "E"));
        print(states.last);

        aux.timeLeft = aux.timeLeft - 1;

        if (aux.timeLeft <= 0) {
          terminated.add(aux);
          states.add(State(aux.id, [inst, inst + quantum - 1], "T"));
          print(states.last);
        } else {
          ready.add(aux);
          states.add(State(aux.id, [inst, inst + quantum - 1], "L"));
          print(states.last);
        }
      } else {
        print('Tiempo muerto');
      }
    }
  }
}
