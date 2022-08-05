part of 'add_result_bloc.dart';

abstract class AddResultEvent{
  const AddResultEvent();
}

class ResultAdded extends AddResultEvent{
  final Module module;
  final String result;
  const ResultAdded({required this.module, required this.result});
}
