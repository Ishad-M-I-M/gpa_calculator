part of 'add_result_bloc.dart';

abstract class AddResultEvent{
  const AddResultEvent();
}

class MountEvent extends AddResultEvent{
  const MountEvent();
}

class SubmitEvent extends AddResultEvent{
  final Module module;
  final String result;
  const SubmitEvent({required this.module, required this.result});
}
