
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
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
                  Text('Praktikum Pertemuan 6 - Tahap 4'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          const FavoriteCounter(),

          const SizedBox(height: 16),

          const Text(
            'Daftar Kursus',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          const CourseTile(
            title: 'Flutter Dasar',
            category: 'Mobile Development',
            icon: Icons.phone_android,
          ),
          const CourseTile(
            title: 'Pemrograman Dart',
            category: 'Programming',
            icon: Icons.code,
          ),
          const CourseTile(
            title: 'UI/UX Design',
            category: 'User Interface',
            icon: Icons.design_services,
          ),
          const CourseTile(
            title: 'State Management',
            category: 'Flutter Architecture',
            icon: Icons.account_tree,
          ),
          const CourseTile(
            title: 'Database Dasar',
            category: 'Data Management',
            icon: Icons.storage,
          ),
        ],
      ),
    );
  }
}

class FavoriteCounter extends StatefulWidget {
  const FavoriteCounter({super.key});

  @override
  State<FavoriteCounter> createState() => _FavoriteCounterState();
}

class _FavoriteCounterState extends State<FavoriteCounter> {
  // ValueNotifier menyimpan satu nilai yang dapat diamati.
  late final ValueNotifier<int> favoriteCount;

  @override
  void initState() {
    super.initState();
    favoriteCount = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    favoriteCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Eksperimen ValueNotifier',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Hanya bagian ini yang mendengarkan perubahan nilai.
            ValueListenableBuilder<int>(
              valueListenable: favoriteCount,
              builder: (context, value, child) {
                return Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Jumlah Favorit: $value',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      favoriteCount.value++;
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('+1 Favorit'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    favoriteCount.value = 0;
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final String title;
  final String category;
  final IconData icon;

  const CourseTile({
    super.key,
    required this.title,
    required this.category,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(title),
        subtitle: Text(category),
      ),
    );
  }
}
