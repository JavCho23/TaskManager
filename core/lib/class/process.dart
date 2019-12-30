class Process {
  int id;
  int arrived;
  int time;
  int timeLeft;
  int priority;
  bool crossed;
  Process(this.id, this.arrived, this.time, this.priority, this.crossed);

  int getTimeLeft() => timeLeft;
}
