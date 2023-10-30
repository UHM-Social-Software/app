import '../../user/domain/user.dart';
import 'course.dart';

class CourseCollection {
  CourseCollection(courses) : _courses = courses;

  final List<Course> _courses;

  Course getCourse(String courseName) {
    return _courses.firstWhere((classData) => classData.name == courseName);
  }

  List<Course> getCourses(User user) {
    return _courses
        .where((courseData) => courseData.students.contains(user.name))
        .toList();
  }

  List<String> getStudentIDs(String courseName){
    return _courses.firstWhere((classData) => classData.name == courseName).students;
  }
}