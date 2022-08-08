import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa_calculator/bloc/semester/semester_bloc.dart';

import '../widgets/module_list_tile.dart';

class SemesterScreen extends StatelessWidget {
  final int semester;

  const SemesterScreen({Key? key, required this.semester}) : super(key: key);

  Widget _getView(BuildContext context, SemesterState state) {
    if (state is Initial){
      context.read<SemesterBloc>().add(LoadEvent(semester: semester));
      return const CircularProgressIndicator();
    }
    else if (state is Loaded){
      if(state.semester.modules.isEmpty){
        return const Center(child: Text("No modules added"));
      }
      else{
        return ListView.builder(
                itemCount: state.semester.modules.length,
                itemBuilder: (context, index) {
                  return ModuleListTile(
                    module: state.semester.modules[index],
                  );
                },
              );
      }
    }
    else{
      return const Center(child: Text("Something went wrong"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Semester $semester"),
        ),
        body: BlocProvider<SemesterBloc>(
          create: (context) => SemesterBloc(),
          child: BlocBuilder<SemesterBloc, SemesterState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<SemesterBloc>().add(LoadEvent(semester: semester));
                },
                child: _getView(context, state),
              );
            },
          ),
        )
    );
  }
}