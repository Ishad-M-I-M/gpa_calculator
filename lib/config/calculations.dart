// import './constants.dart';
import 'package:gpa_calculator/config/constants.dart';
import 'package:gpa_calculator/models/module.dart';
import 'package:gpa_calculator/models/result.dart';

import '../db/SQLHelper.dart';
import '../models/semester.dart';

double getEnrolledCredits(Semester semester){
  return semester.modules.fold(0, (sum, module) => sum + module.credits);
}

Future<double> getSGPA(Semester semester) async{
  double total = await _getTotals(semester);
  return  total/ _getEffectiveCredits(semester);
}

double _getEffectiveCredits(Semester semester){
  return semester.modules.fold(0, (sum, module) {
    if (module.result == "Pending") return sum;
    return sum + module.credits ;
  });
}

Future<double> _getTotals(Semester semester) async{
  List<Result> gpas = await SQLHelper.getGPAs();
  Map<String, double> gpaValues = {};
  for(Result res in gpas){
    gpaValues[res.result] = res.gpa;
  }

  double total = 0;
  for(Module module in semester.modules){
    if (module.result != "Pending") total = module.credits * gpaValues[module.result]!;
  }
  return total;
}

Future<double> getCGPA(List<Semester> semesters) async{
  double total =0;
  for(Semester semester in semesters){
    double semTotal = await _getTotals(semester);
    total += semTotal;
  }
  double effectiveCredits = semesters.fold(0, (sum, semester) {
    return sum + _getEffectiveCredits(semester);
  });
  return total / effectiveCredits;
}