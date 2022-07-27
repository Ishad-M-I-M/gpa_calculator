class Result {
  final int id;
  final String result;
  final double gpa;

  Result({this.id = -1, required this.result, required this.gpa});

  Map<String, Object> toMap(){
    return {
      "result": result,
      "gpa": gpa
    };
  }
}
