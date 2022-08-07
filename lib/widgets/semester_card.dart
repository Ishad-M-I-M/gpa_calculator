import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/semester/semester_bloc.dart';

class SemesterCard extends StatelessWidget {
  final int semester;
  final Function onTap;

  const SemesterCard({required this.semester, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SemesterBloc>(
        create: (context) => SemesterBloc(),
        child:
            BlocBuilder<SemesterBloc, SemesterState>(builder: (context, state) {
          if (state is Initial) {
            context.read<SemesterBloc>().add(LoadEvent(semester: semester));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is Loaded) {
            return InkWell(
              onTap: () => onTap(context),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(3, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Semester ${state.semester.semester}",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Credits Enrolled: ${state.semester.credits.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "SGPA:  ${state.semester.sgpa.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        }));
  }
}
