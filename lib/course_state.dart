
import 'package:flutter/foundation.dart';

class CourseState extends ChangeNotifier {
  final Set<String> _favorites = {};

  Set<String> get favorites => Set.unmodifiable(_favorites);

  bool isFavorite(String course) {
    return _favorites.contains(course);
  }

  void toggleFavorite(String course) {
    if (_favorites.contains(course)) {
      _favorites.remove(course);
    } else {
      _favorites.add(course);
    }

    notifyListeners();
  }
}
