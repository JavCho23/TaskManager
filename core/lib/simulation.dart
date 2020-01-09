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

  InterruptionConfig getInterruptionConfig(int type) {
    for (InterruptionConfig item in interruptions) {
      if (item.tipo == type) return item;
    }
    return null;
  }

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
    int quantumtotal = 2, lost = 0;
    while (terminated.getLength() != ew.getLength()) {
      print("----------------");
      quantumtotal++;
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
          Interruption interruption = aux.getNextInterruption();
          if (interruption == null || interruption.inst != inst + quantum - 1) {
            ready.add(aux);
            states.add(State(aux.id, [inst, inst + quantum - 1], "L"));
            print(states.last);
          } else {
            aux.block =
                quantumtotal + getInterruptionConfig(interruption.tipo).blocked;
            aux.lastType = interruption.tipo;
            bloked.add(aux);
            states.add(State(aux.id, [inst, inst + quantum - 1],
                'B(' + interruption.tipo.toString() + ')'));
            print(states.last);
          }
        }
      } else {
        print('Tiempo muerto');
      }
      List<Process> blockFree = [], suspendedFree = [];

      for (Process block in bloked.data) {
        if (block.block == quantumtotal) {
          blockFree.add(block);
        }
      }
      for (Process block in blockFree) {
        if (getInterruptionConfig(block.lastType).suspended > 0) {
          block.sus =
              getInterruptionConfig(block.lastType).suspended + quantumtotal;
          suspended.add(block);
          states.add(
              State(block.id, [0, 0], 'S(' + block.lastType.toString() + ')'));
          print(states.last);
        } else {
          block.deleteInterruption(block.lastType);
          if (block.timeLeft <= 0) {
            lost++;
            states.add(State(block.id, [0, 0], "P"));
            print(states.last);
          } else {
            ready.add(block);
            states.add(State(block.id, [0, 0], "L"));
            print(states.last);
          }
        }
      }

      for (Process sus in suspended.data) {
        if (sus.sus == quantumtotal) suspendedFree.add(sus);
      }
      for (Process sus in suspendedFree) {
        sus.deleteInterruption(sus.lastType);
        if (sus.timeLeft <= 0) {
          lost++;
          states.add(State(sus.id, [0, 0], "P"));
          print(states.last);
        } else {
          ready.add(sus);
          states.add(State(sus.id, [0, 0], "L"));
          print(states.last);
        }
      }
    }
  }
}
