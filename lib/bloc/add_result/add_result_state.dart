part of 'add_result_bloc.dart';

abstract class AddResultState{
  const AddResultState();
}

class Initial extends AddResultState {}

class Loaded extends AddResultState {}

class Submitted extends AddResultState {}

class Saved extends AddResultState {}

class SaveFailed extends AddResultState {}
