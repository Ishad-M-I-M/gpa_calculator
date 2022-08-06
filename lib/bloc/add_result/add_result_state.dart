part of 'add_result_bloc.dart';

abstract class AddResultState{
  const AddResultState();
}

class Initial extends AddResultState {}

class Loaded extends AddResultState {
  final List<Result> results;
  const Loaded({required this.results});
}

class Submitted extends AddResultState {}

class Saved extends AddResultState {}

class Error extends AddResultState {
  final String message;
  const Error(this.message);
}
