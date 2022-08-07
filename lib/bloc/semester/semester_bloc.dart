import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../config/calculations.dart';
import '../../models/module.dart';
import '../../models/semester.dart';
import '../../db/SQLHelper.dart';

part 'semester_event.dart';
part 'semester_state.dart';

class SemesterBloc extends Bloc<SemesterEvent, SemesterState> {
  SemesterBloc() : super(Initial()) {
    on<LoadEvent>((event, emit) async {
      List<Module> moduleList =
      await SQLHelper.getModulesWhere({"semester": event.semester.toString()});
      double sgpa = await getSGPA(event.semester);
      double credits = await getEnrolledCredits(event.semester);
      Semester semester = Semester(semester: event.semester, modules: moduleList, credits: credits, sgpa: sgpa);
      emit(Loaded(semester));
    });
  }
}
