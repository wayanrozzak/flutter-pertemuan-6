
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_state.dart';
import 'models/course.dart';

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

  @override
  Widget build(BuildContext context) {
    // WATCH: UI mendengarkan perubahan state dari Provider.
    final courseState = context.watch<CourseState>();
    final courses = courseState.courses;
    final favoriteCount = courseState.favorites.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
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
                  Text('Tahap 10: Repository Pattern'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Jumlah Favorit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '$favoriteCount',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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

          if (courseState.isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),
            )
          else if (courseState.errorMessage != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(courseState.errorMessage!),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CourseState>().loadCourses();
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            )
          else if (courses.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Belum ada data course.'),
            )
          else
            ...courses.map((Course course) {
              final isFavorite =
                  courseState.isFavorite(course.title);

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(course.title),
                  subtitle: Text(
                    '${course.code} • ${course.credits} SKS • '
                    '${course.status}',
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
                    // READ: mengambil Provider untuk menjalankan aksi.
                    onPressed: () {
                      context
                          .read<CourseState>()
                          .toggleFavorite(course.title);
                    },
                  ),
                ),
              );
            }),

          const SizedBox(height: 16),

          Consumer<CourseState>(
            builder: (context, state, child) {
              final favorites = state.favorites.toList();

              return Card(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
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

                      if (favorites.isEmpty)
                        const Text(
                          'Belum ada course favorit.',
                        )
                      else
                        ...favorites.map(
                          (courseTitle) => Padding(
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 3,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(courseTitle),
                                ),
                              ],
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
