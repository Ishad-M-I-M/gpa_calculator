import './constants.dart';
import '../models/semester.dart';

double getEnrolledCredits(Semester semester){
  return semester.modules.fold(0, (sum, module) => sum + module.credits);
}

double getSGPA(Semester semester){
  return _getTotals(semester) / _getEffectiveCredits(semester);
}

double _getEffectiveCredits(Semester semester){
  return semester.modules.fold(0, (sum, module) {
    if (module.result == "Pending") return sum;
    return sum + module.credits ;
  });
}

double _getTotals(Semester semester){
  return semester.modules.fold(0, (sum, module) {
    if (module.result == "Pending") return sum;
    return sum +  (gpaValues[module.result] != null ? module.credits * gpaValues[module.result]!: 0);
  });
}

double getCGPA(List<Semester> semesters){
  double total = semesters.fold(0, (sum, semester) {
    return sum + _getTotals(semester);
  });
  double effectiveCredits = semesters.fold(0, (sum, semester) {
    return sum + _getEffectiveCredits(semester);
  });
  return total / effectiveCredits;
}