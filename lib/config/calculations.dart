import '../models/module.dart';
import '../models/result.dart';
import '../models/semester.dart';

import '../db/SQLHelper.dart';

Future<double> getEnrolledCredits(int semester) async{
  List<Module> modules = await SQLHelper.getModulesWhere({"semester": semester.toString()});

  double total = 0;
  for(Module module in modules){
    total += module.credits ;
  }
  return total;
}

Future<double> getSGPA(int semester) async{
  List<Module> modules = await SQLHelper.getModulesWhere({"semester": semester.toString()});
  double total = await _getTotals(modules);
  return  total/ _getEffectiveCredits(modules);
}

double _getEffectiveCredits(List<Module> modules){
  return modules.fold(0, (sum, module) {
    if (module.result == "Pending") return sum;
    return sum + module.credits ;
  });
}

Future<double> _getTotals(List<Module> modules) async{
  List<Result> gpas = await SQLHelper.getGPAs();
  Map<String, double> gpaValues = {};
  for(Result res in gpas){
    gpaValues[res.result] = res.gpa;
  }

  double total = 0;
  for(Module module in modules){
    if (module.result != "Pending") total += module.credits * gpaValues[module.result]!;
  }
  return total;
}

Future<double> getCGPA() async{
  List<Module> modules = await SQLHelper.getModules();
  double total = await _getTotals(modules);
  return  total/ _getEffectiveCredits(modules);
}