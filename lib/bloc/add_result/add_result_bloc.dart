import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../models/module.dart';
import '../../db/SQLHelper.dart';
import '../../models/result.dart';

part 'add_result_event.dart';
part 'add_result_state.dart';

class AddResultBloc extends Bloc<AddResultEvent, AddResultState> {
  AddResultBloc() : super(Initial()) {
    on<MountEvent>((event, emit) async {
      debugPrint("MountEvent");
      try{
          List<Result> results = await SQLHelper.getGPAs();
          emit(Loaded(results: results));
      }
      catch(e){
        emit(const Error("Unable to load results"));
      }
    });

    on<SubmitEvent>((event, emit) async {
      Module updateModule = event.module;
      updateModule.result = event.result;
      try{
        await SQLHelper.updateModule(updateModule);
        emit(Saved());
      }
      catch(e){
        emit(const Error("Saving Failed"));
      }
    });
  }
}
