class AlarmSetting {
  String? value;
  AlarmType typ;
  AlarmSetting(String this.value, AlarmType this.typ);
  Map toJson() => {'value': value, 'typ': typ.toString()};
  @override
  String toString() {
    return "${this.value}, ${this.typ}";
  }
}

enum AlarmType {
  lower,

  higher,
}
