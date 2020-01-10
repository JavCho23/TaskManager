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
  List states = [];
  List<InterruptionConfig> interruptions;
  int quantum;

  TaskManager(this.ew, this.ready, this.bloked, this.suspended, this.quantum,
      this.interruptions) {
    executing = StructureQuewe([]);
    terminated = StructureQuewe([]);
  }

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
          [0, (quantum * ew.data.elementAt(i).time) - 1], "N"));
      print(states.elementAt(i));
    }
    print("----------------");

    for (int i = 0; i < ready.getLength(); i++) {
      states.add(State(ready.data.elementAt(i).id,
          [0, (quantum * ready.data.elementAt(i).time) - 1], "L"));
      print(states.last);
    }
    int quantumtotal = 2;
    int lost = 0;
    while (terminated.getLength() + lost != ew.getLength()) {
      print("----------------");
      quantumtotal++;
      Process aux = ready.getNext();
      if (aux != null) {
        executing.add(aux);
        int inst = (aux.time - aux.timeLeft) * quantum;
        states.add(State(aux.id, [inst, inst + quantum - 1], "E"));
        print(states.last);
        aux.timeLeft = aux.timeLeft - 1;

        Interruption interruption = aux.getNextInterruption();
        if (interruption == null || interruption.inst != inst + quantum - 1) {
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
          aux.block =
              quantumtotal + getInterruptionConfig(interruption.tipo).blocked;
          aux.lastType = interruption.tipo;
          aux.inst = inst;
          bloked.add(aux);
          states.add(State(aux.id, [inst, inst + quantum - 1],
              'B(' + interruption.tipo.toString() + ')'));
          print(states.last);
        }
      } else {
        states.add('Tiempo muerto');
        print(states.last);
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
          states.add(State(block.id, [block.inst, block.inst + quantum - 1],
              'S(' + block.lastType.toString() + ')'));
          print(states.last);
        } else {
          block.deleteInterruption(block.lastType);
          if (block.timeLeft <= 0) {
            lost++;
            states.add(
                State(block.id, [block.inst, block.inst + quantum - 1], "P"));
            print(states.last);
          } else {
            ready.add(block);
            states.add(
                State(block.id, [block.inst, block.inst + quantum - 1], "L"));
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
          states.add(State(sus.id, [sus.inst, sus.inst + quantum - 1], "P"));
          print(states.last);
        } else {
          ready.add(sus);
          states.add(State(sus.id, [sus.inst, sus.inst + quantum - 1], "L"));
          print(states.last);
        }
      }
    }
  }
}
