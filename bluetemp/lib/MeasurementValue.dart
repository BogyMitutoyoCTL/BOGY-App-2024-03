class MeasurementValue {
  late double temperature;
  late DateTime time;
  MeasurementValue(double a, DateTime b) {
    temperature = a;
    time = b;
  }
  Map toJson() => {'value': temperature, 'time': time.toString()};
  MeasurementValue.fromJson(Map<dynamic, dynamic> m) {
    temperature = m["value"]!;
    String time_string = m["time"]!;
    time = DateTime.parse(time_string);
  }
  @override
  String toString() {
    return "${this.temperature}, ${this.time}";
  }
}
