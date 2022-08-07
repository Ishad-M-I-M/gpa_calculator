part of 'semester_bloc.dart';

@immutable
abstract class SemesterEvent {}

class LoadEvent extends SemesterEvent {
  final int semester;
  LoadEvent({required this.semester});
}