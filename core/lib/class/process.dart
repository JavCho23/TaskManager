class Process {
  int id;
  int arrived;
  int time;
  int timeLeft;
  int priority;
  bool crossed = false;
  Process(this.id, this.arrived, this.time, this.priority);

  int getTimeLeft() => timeLeft;

  @override
  String toString() {
    // TODO: implement toString
    return 'P$id timeleft:$time';
  }
}
