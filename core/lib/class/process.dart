class Process {
  int id;
  int arrived;
  int time;
  int priority;
  bool crossed = false;
  int timeLeft;
  List<List<int>> interruption;
  Process(this.id, this.arrived, this.time, this.priority, this.timeLeft,this.interruption);

  @override
  String toString() {
    return 'P$id timeleft:$time';
  }
}
