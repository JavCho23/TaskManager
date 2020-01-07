class State {
  int id;
  List<int> inst;
  String state;

  State(this.id, this.inst, this.state);

  @override
  String toString() {
    // TODO: implement toString
    return 'P$id $inst $state';
  }
}
