
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import 'course_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final courses = provider.favoriteCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mata Kuliah Favorit'),
      ),
      body: courses.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, size: 64),
                  SizedBox(height: 12),
                  Text('Belum ada mata kuliah favorit.'),
                  Text('Tambahkan favorit dari daftar mata kuliah.'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.school),
                    ),
                    title: Text(course.title),
                    subtitle: Text(
                      '${course.code} • ${course.credits} SKS',
                    ),
                    trailing: IconButton(
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context
                            .read<CourseProvider>()
                            .toggleFavorite(course.code);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseDetailPage(
                            course: course,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
