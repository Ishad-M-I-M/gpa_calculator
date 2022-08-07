part of 'semester_bloc.dart';

@immutable
abstract class SemesterState {}

class Initial extends SemesterState {}

class Loaded extends SemesterState {
  final Semester semester;
  Loaded( this.semester);
}