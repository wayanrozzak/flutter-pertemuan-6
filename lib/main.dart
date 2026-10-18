
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

  // Data JSON diubah menjadi object Course menggunakan fromJson().
  static final List<Course> courses = [
    Course.fromJson({
      'code': 'IF101',
      'title': 'Flutter Dasar',
      'credits': 2,
      'status': 'Aktif',
    }),
    Course.fromJson({
      'code': 'IF102',
      'title': 'UI Fundamentals',
      'credits': 3,
      'status': 'Aktif',
    }),
    Course.fromJson({
      'code': 'IF103',
      'title': 'State Management',
      'credits': 3,
      'status': 'Aktif',
    }),
    Course.fromJson({
      'code': 'IF104',
      'title': 'Mobile Application Architecture',
      'credits': 3,
      'status': 'Aktif',
    }),
    Course.fromJson({
      'code': 'IF105',
      'title': 'Database Mobile',
      'credits': 3,
      'status': 'Aktif',
    }),
  ];

  @override
  Widget build(BuildContext context) {
    // WATCH: mendengarkan perubahan state favorit.
    final courseState = context.watch<CourseState>();
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
          // Identitas mahasiswa.
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
                  Text('Tahap 8: Model Course dan Parsing JSON'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Jumlah favorit menggunakan state dari Provider.
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

          // Data yang ditampilkan berasal dari object Course.
          ...courses.map((course) {
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

          // CONSUMER: memperbarui bagian ringkasan favorit.
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
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
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
