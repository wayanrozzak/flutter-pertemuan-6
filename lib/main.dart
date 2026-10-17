
import 'package:flutter/material.dart';

void main() {
  runApp(const CourseExplorerApp());
}

const String studentName = 'Wayan Muizul Rozzak';
const String studentId = '2415051111';

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
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

class CourseExplorerPage extends StatefulWidget {
  const CourseExplorerPage({super.key});

  @override
  State<CourseExplorerPage> createState() =>
      _CourseExplorerPageState();
}

class _CourseExplorerPageState extends State<CourseExplorerPage> {
  // LOCAL STATE: hanya digunakan pada halaman ini.
  final Set<int> _favoriteCourses = {};
  int? _expandedCourseId;

  final List<Map<String, dynamic>> _courses = [
    {
      'id': 1,
      'title': 'Flutter Dasar',
      'category': 'Mobile Development',
      'description':
          'Belajar widget, layout, dan dasar pembuatan aplikasi Flutter.',
      'icon': Icons.phone_android,
    },
    {
      'id': 2,
      'title': 'Pemrograman Dart',
      'category': 'Programming',
      'description':
          'Mengenal variabel, fungsi, class, dan pemrograman Dart.',
      'icon': Icons.code,
    },
    {
      'id': 3,
      'title': 'UI/UX Design',
      'category': 'User Interface',
      'description':
          'Mempelajari prinsip desain antarmuka dan pengalaman pengguna.',
      'icon': Icons.design_services,
    },
    {
      'id': 4,
      'title': 'State Management',
      'category': 'Flutter Architecture',
      'description':
          'Memahami local state, shared state, dan pengelolaan data.',
      'icon': Icons.account_tree,
    },
    {
      'id': 5,
      'title': 'Database Dasar',
      'category': 'Data Management',
      'description':
          'Mengenal konsep penyimpanan dan pengelolaan data aplikasi.',
      'icon': Icons.storage,
    },
  ];

  // Contoh LOCAL STATE menggunakan setState().
  void _toggleFavorite(int courseId) {
    setState(() {
      if (_favoriteCourses.contains(courseId)) {
        _favoriteCourses.remove(courseId);
      } else {
        _favoriteCourses.add(courseId);
      }
    });
  }

  void _toggleDetails(int courseId) {
    setState(() {
      _expandedCourseId =
          _expandedCourseId == courseId ? null : courseId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course Explorer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Identitas mahasiswa untuk bukti praktikum.
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
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
                Text(
                  'Praktikum Pertemuan 6 - Tahap 1',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Daftar Kursus',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  avatar: const Icon(
                    Icons.favorite,
                    size: 18,
                    color: Colors.red,
                  ),
                  label: Text('${_favoriteCourses.length} Favorit'),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
                final int id = course['id'] as int;
                final bool isFavorite =
                    _favoriteCourses.contains(id);
                final bool isExpanded =
                    _expandedCourseId == id;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              child: Icon(
                                course['icon'] as IconData,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    course['category'] as String,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              tooltip: isFavorite
                                  ? 'Hapus dari favorit'
                                  : 'Tambahkan ke favorit',
                              onPressed: () =>
                                  _toggleFavorite(id),
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () => _toggleDetails(id),
                            icon: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                            label: Text(
                              isExpanded
                                  ? 'Sembunyikan detail'
                                  : 'Lihat detail',
                            ),
                          ),
                        ),
                        if (isExpanded)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              course['description'] as String,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
