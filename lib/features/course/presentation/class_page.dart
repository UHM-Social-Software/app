import 'package:app/features/course/domain/course_collection.dart';
import 'package:app/features/user/presentation/student_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../agc_error.dart';
import '../../../agc_loading.dart';
import '../../all_data_provider.dart';

/// Displays a list of Students in a class.
class ClassPage extends ConsumerWidget {
  const ClassPage({
    super.key,
    required this.className,
  });

  static const routeName = '/ClassPage';
  final String className;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          courses: allData.courses,
        ),
        loading: () => const AGCLoading(),
        error: (error, st) => AGCError(error.toString(), st.toString()));
  }

  Widget _build(
      {required BuildContext context, required courses}) {
    final courseCollection = CourseCollection(courses);
    List<String> studentIDs = courseCollection.getStudentIDs(className);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(38, 95, 70, 1.0),
        title: Text(className),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ...studentIDs
                            .map((student) => StudentBar(userID: student))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
