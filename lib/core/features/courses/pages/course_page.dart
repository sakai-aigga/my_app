// main course page
import 'package:flutter/material.dart';
import 'package:my_app/core/features/courses/data/course_data.dart';
import 'package:my_app/core/features/courses/widgets/course_header_card.dart'; 
import 'package:my_app/core/features/courses/widgets/course_tile.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const CoursesHeaderCard();
        }

        final course = courses[index - 1];
        return CourseTile(course: course);
      },
    );
  }
}
