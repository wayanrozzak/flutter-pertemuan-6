
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const CourseExplorerPage(),
    );
  }
}

class CourseExplorerPage extends StatelessWidget {
  const CourseExplorerPage({super.key});

  static const List<String> courses = [
    'Flutter Dasar',
    'UI Fundamentals',
    'State Management',
    'Mobile Application Architecture',
    'Database Mobile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<CourseState>(
        builder: (context, courseState, child) {
          final favorites = courses
              .where((course) => courseState.isFavorite(course))
              .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wayan Muizul Rozzak',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('NIM: 2415051111'),
                      SizedBox(height: 8),
                      Text('Tahap 6: Provider'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ringkasan Favorit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Jumlah Favorit: ${favorites.length}'),
                      const SizedBox(height: 8),
                      if (favorites.isEmpty)
                        const Text('Belum ada course favorit.')
                      else
                        ...favorites.map(
                          (course) => Text('• $course'),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Daftar Course',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...courses.map((course) {
                final isFavorite =
                    courseState.isFavorite(course);

                return Card(
                  child: ListTile(
                    title: Text(course),
                    subtitle: Text(
                      isFavorite
                          ? 'Course favorit'
                          : 'Belum menjadi favorit',
                    ),
                    trailing: IconButton(
                      tooltip: isFavorite
                          ? 'Hapus dari favorit'
                          : 'Tambah ke favorit',
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        courseState.toggleFavorite(course);
                      },
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
