import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../models/module.dart';
import '../../db/SQLHelper.dart';

part 'add_result_event.dart';
part 'add_result_state.dart';

class AddResultBloc extends Bloc<AddResultEvent, AddResultState> {
  AddResultBloc() : super(Initial()) {
    on<ResultAdded>((event, emit) {
      Module updateModule = event.module;
      updateModule.result = event.result;
      SQLHelper.updateModule(updateModule);
      debugPrint(event.result);
    });
  }
}
