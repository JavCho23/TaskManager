class InterruptionConfig {
  int tipo;
  int blocked;
  int suspended;
  InterruptionConfig(this.tipo, this.blocked, this.suspended);
}

class Interruption {
  int tipo;
  int inst;

  Interruption(this.tipo, this.inst);
}
