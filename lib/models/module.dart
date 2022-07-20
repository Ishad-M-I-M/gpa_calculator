class Module {
  final int id;
  final String code;
  final String name;
  final double credits;
  final int semester;
  String result;

  Module(
      {this.id = -1,
      required this.code,
      required this.name,
      required this.credits,
      required this.semester,
      this.result = "Pending"});

  Map<String, Object> toMap() {
    return {
      "code": code,
      "name": name,
      "credits": credits,
      "semester": semester,
      "result": result
    };
  }
}
