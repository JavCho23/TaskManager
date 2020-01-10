import 'package:core/class/interruption.dart';

class Process {
  int id;
  int arrived;
  int time;
  int priority;
  bool crossed = false;
  int timeLeft;
  int block;
  int sus;
  int lastType;
  int inst;
  List<Interruption> interruptions;
  Process(this.id, this.arrived, this.time, this.priority, this.interruptions) {
    ordenarInterrupciones(interruptions, 0, interruptions.length - 1);
    lastType = 0;
    timeLeft = time;
    block = 0;
  }
  Process.clone(this.id, this.arrived, this.time, this.priority, this.timeLeft,
      this.interruptions, this.block, this.lastType, this.sus, this.inst);
  Interruption getNextInterruption() {
    if (interruptions.length > 0) return interruptions.first;
    return null;
  }

  void deleteInterruption(int type) {
    for (Interruption interruption in interruptions) {
      if (interruption.tipo == type) {
        interruptions.remove(interruption);
        break;
      }
    }
  }

  void ordenarInterrupciones(List<Interruption> data, int izq, int der) {
    Interruption pivote = data[izq]; // tomamos primer elemento como pivote
    int i = izq; // i realiza la búsqueda de izquierda a derecha
    int j = der; // j realiza la búsqueda de derecha a izquierda
    Interruption aux;

    while (i < j) {
      // mientras no se crucen las búsquedas
      while (data[i].inst <= pivote.inst && i < j)
        i++; // busca elemento mayor que pivote
      while (data[j].inst > pivote.inst) j--; // busca elemento menor que pivote
      if (i < j) {
        // si no se han cruzado
        aux = data[i]; // los intercambia
        data[i] = data[j];
        data[j] = aux;
      }
    }
    data[izq] =
        data[j]; // se coloca el pivote en su lugar de forma que tendremos
    data[j] = pivote; // los menores a su izquierda y los mayores a su derecha
    if (izq < j - 1)
      ordenarInterrupciones(data, izq, j - 1); // ordenamos subarray izquierdo
    if (j + 1 < der)
      ordenarInterrupciones(data, j + 1, der); // ordenamos subarray derecho
  }

  @override
  String toString() {
    return 'P$id timeleft:$time';
  }
}
