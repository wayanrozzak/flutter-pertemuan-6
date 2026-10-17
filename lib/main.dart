
import 'package:flutter/material.dart';
import 'course_state.dart';

void main() {
  runApp(const CourseExplorerApp());
}

const String studentName = 'Wayan Muizul Rozzak';
const String studentId = '2415051111';

const List<Map<String, String>> courses = [
  {'id': '1', 'title': 'Flutter Dasar', 'category': 'Mobile Development'},
  {'id': '2', 'title': 'Pemrograman Dart', 'category': 'Programming'},
  {'id': '3', 'title': 'UI/UX Design', 'category': 'User Interface'},
  {'id': '4', 'title': 'State Management', 'category': 'Flutter Architecture'},
  {'id': '5', 'title': 'Database Dasar', 'category': 'Data Management'},
];

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CourseExplorerPage(),
    );
  }
}

class CourseExplorerPage extends StatefulWidget {
  const CourseExplorerPage({super.key});

  @override
  State<CourseExplorerPage> createState() => _CourseExplorerPageState();
}

class _CourseExplorerPageState extends State<CourseExplorerPage> {
  // Satu object state digunakan oleh kedua bagian UI.
  late final CourseState courseState;

  @override
  void initState() {
    super.initState();
    courseState = CourseState();
  }

  @override
  void dispose() {
    courseState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('NIM: $studentId'),
                  SizedBox(height: 8),
                  Text('Praktikum Pertemuan 6 - Tahap 5'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Listener pertama: daftar kursus.
          AnimatedBuilder(
            animation: courseState,
            builder: (context, child) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daftar Kursus',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...courses.map((course) {
                        final id = course['id']!;
                        final isFavorite = courseState.isFavorite(id);

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(course['title']!),
                          subtitle: Text(course['category']!),
                          trailing: IconButton(
                            tooltip: isFavorite
                                ? 'Hapus dari favorit'
                                : 'Tambahkan ke favorit',
                            onPressed: () {
                              courseState.toggleFavorite(id);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Listener kedua: ringkasan favorit.
          AnimatedBuilder(
            animation: courseState,
            builder: (context, child) {
              final favoriteCourses = courses
                  .where(
                    (course) =>
                        courseState.isFavorite(course['id']!),
                  )
                  .toList();

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kursus Favorit (${courseState.favorites.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (favoriteCourses.isEmpty)
                        const Text('Belum ada kursus favorit.')
                      else
                        ...favoriteCourses.map(
                          (course) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(course['title']!),
                            trailing: IconButton(
                              tooltip: 'Hapus dari favorit',
                              onPressed: () {
                                courseState.toggleFavorite(
                                  course['id']!,
                                );
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
