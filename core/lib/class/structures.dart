import 'process.dart';

abstract class Structure {
  List<Process> data;

  Process getNext();
}

class StructureStack extends Structure {
  @override
  Process getNext() => data.first;
}

class StrutureQuewe extends Structure {
  @override
  Process getNext() => data.last;
}

class StructurePriority extends Structure {
  @override
  Process getNext() {
    // TODO: implement getNext
    int next = 0;
    for (int index = 0; index < data.length; index++) {
      if (data.elementAt(index).crossed) {
        if (data.elementAt(index).priority < data.elementAt(next).priority)
          next = index;
        else if (data.elementAt(index).priority ==
            data.elementAt(next).priority) {
          if (data.elementAt(index).arrived < data.elementAt(next).arrived)
            next = index;
        }
      }
    }
    return data.elementAt(next);
  }
}
