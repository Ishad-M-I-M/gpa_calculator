import './constants.dart';
import '../models/semester.dart';

double getEnrolledCredits(Semester semester){
  return semester.modules.fold(0, (sum, module) => sum + module.credits);
}

double getSGPA(Semester semester){
  double total = semester.modules.fold(0, (sum, module) {
    if (module.result == "Pending") return sum;
    return sum +  (gpaValues[module.result] != null ? module.credits * gpaValues[module.result]!: 0);
  });
  double effectiveCredits = semester.modules.fold(0, (sum, module) {
    if (module.result == "Pending") return sum;
    return sum + module.credits ;
  });
  return total / effectiveCredits;
}