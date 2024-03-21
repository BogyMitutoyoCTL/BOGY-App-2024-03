class AlarmSetting {
  late String value;
  late AlarmType typ;
  AlarmSetting(String this.value, AlarmType this.typ);
  Map toJson() => {'value': value, 'typ': typ.name};
  AlarmSetting.fromJson(Map<dynamic, dynamic> json) {
    value = json["value"]!;
    typ = AlarmType.values.byName(json["typ"]!);
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
