
import 'package:flutter/foundation.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  CourseProvider(this.repository);

  List<Course> courses = [];
  bool isLoading = false;
  String? error;

  final Set<String> _favorites = {};

  Set<String> get favorites => Set.unmodifiable(_favorites);

  bool isFavorite(String courseTitle) {
    return _favorites.contains(courseTitle);
  }

  void toggleFavorite(String courseTitle) {
    if (_favorites.contains(courseTitle)) {
      _favorites.remove(courseTitle);
    } else {
      _favorites.add(courseTitle);
    }

    notifyListeners();
  }

  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
