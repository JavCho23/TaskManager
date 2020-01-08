import 'process.dart';

abstract class Structure {
  List<Process> data;
  Structure(this.data);
  Process getNext();
  void ordenar(List<Process> data, int izq, int der) {
    Process pivote = data[izq]; // tomamos primer elemento como pivote
    int i = izq; // i realiza la búsqueda de izquierda a derecha
    int j = der; // j realiza la búsqueda de derecha a izquierda
    Process aux;

    while (i < j) {
      // mientras no se crucen las búsquedas
      while (data[i].arrived <= pivote.arrived && i < j)
        i++; // busca elemento mayor que pivote
      while (data[j].arrived > pivote.arrived)
        j--; // busca elemento menor que pivote
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
    if (izq < j - 1) ordenar(data, izq, j - 1); // ordenamos subarray izquierdo
    if (j + 1 < der) ordenar(data, j + 1, der); // ordenamos subarray derecho
  }

  void add(Process process) {
    data.add(Process(
        process.id,
        process.arrived,
        process.time,
        process.priority,
        process.timeLeft,
        process.interruptions,
        process.block));
  }

  int getLength() => data.length;
}

class StructureStack extends Structure {
  StructureStack(List<Process> data) : super(data);

  @override
  Process getNext() {
    for (var i = data.length - 1; i >= 0; i--) {
      if (!data.elementAt(i).crossed && data.elementAt(i).block == 0) {
        data.elementAt(i).crossed = true;
        return data.elementAt(i);
      }
    }
    return null;
  }
}

class StructureQuewe extends Structure {
  StructureQuewe(List<Process> data) : super(data);

  @override
  Process getNext() {
    for (Process process in data) {
      if (!process.crossed && process.block == 0) {
        Process next = process;
        process.crossed = true;
        return next;
      }
    }
    return null;
  }
}

class StructurePriority extends Structure {
  List<int> orden;
  int next;
  StructurePriority(List<Process> data, this.orden) : super(data);

  @override
  Process getNext() {
    List<Process> priority = [];
    bool sw = false;
    for (var i = 0; i < orden.length; i++) {
      for (Process process in data) {
        if (orden.elementAt(i) == process.priority &&
            !process.crossed &&
            process.block == 0) {
          priority.add(process);
          if (!sw) sw = true;
        }
      }
      if (sw) {
        break;
      }
    }

    if (priority.isNotEmpty) {
      ordenar(priority, 0, priority.length - 1);
      next = next = data.lastIndexOf(priority.first);
      data.elementAt(next).crossed = true;
      return priority.first;
    }

    return null;
  }
}
