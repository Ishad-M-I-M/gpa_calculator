
import './module.dart';

class Semester{
  final int semester;
  List<Module> modules;
  double credits;
  double sgpa;
  Semester({required this.semester, this.modules = const [], this.credits = 0.0, this.sgpa = 0.0});
}