class AlarmSetting {
  late String value;
  late AlarmType typ;
  AlarmSetting(String this.value, AlarmType this.typ);
  Map toJson() => {'value': value, 'typ': typ.name};
  AlarmSetting.fromJson(Map<dynamic, dynamic> m) {
    value = m["value"]!;
    String typName = m["typ"]!;
    typ = AlarmType.values.byName(typName);
  }
  @override
  String toString() {
    return "${this.value}, ${this.typ}";
  }
}

enum AlarmType {
  lower,

  higher,
}
