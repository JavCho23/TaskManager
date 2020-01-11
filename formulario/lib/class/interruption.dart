class InterruptionConfig {
  int tipo;
  int blocked;
  int suspended;
  InterruptionConfig(this.tipo, this.blocked, this.suspended);
  InterruptionConfig.empy(this.tipo);
}

class Interruption {
  int tipo;
  int inst;

  Interruption(this.tipo, this.inst);
  Interruption.empy(this.tipo);
}
