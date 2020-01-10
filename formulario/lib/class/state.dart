class StateQ {
  int id;
  List<int> inst;
  String state;

  StateQ(this.id, this.inst, this.state);

  @override
  String toString() {
    return 'P$id $inst $state';
  }
}
