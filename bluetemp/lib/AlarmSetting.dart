class AlarmSetting {
  int? value;
  AlarmType typ;
  AlarmSetting(int this.value, AlarmType this.typ);
  @override
  String toString() {
    return "${this.value}, ${this.typ}";
  }
}

enum AlarmType {
  minimum,

  maximum,
}
