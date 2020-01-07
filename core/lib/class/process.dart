class Process {
  int id;
  int arrived;
  int time;
  int priority;
  bool crossed = false;

  Process(this.id, this.arrived, this.time, this.priority);

  

  @override
  String toString() {
    // TODO: implement toString
    return 'P$id timeleft:$time';
  }
}
