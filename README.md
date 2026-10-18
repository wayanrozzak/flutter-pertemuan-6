## Tahap 16: Audit Architecture dan Dependency Direction

### Tanggung Jawab Setiap Folder

- **models/**: Mendefinisikan struktur data mata kuliah melalui class `Course`.
- **services/**: Membaca file JSON menggunakan `rootBundle`, memproses JSON dengan `jsonDecode`, dan mengubah data menjadi objek `Course`.
- **repositories/**: Menjadi perantara antara Provider dan Service dalam pengambilan data.
- **providers/**: Mengelola state aplikasi, termasuk daftar mata kuliah, loading, error, dan favorit menggunakan `ChangeNotifier`.
- **screens/**: Menyediakan halaman utama, detail mata kuliah, dan daftar favorit.
- **widgets/**: Menyimpan komponen UI yang dapat digunakan kembali.
- **assets/data/**: Menyimpan file JSON sebagai sumber data mata kuliah.

### Arah Dependency

Arah dependency aplikasi adalah:

`Screens/Widgets → Provider → Repository → Service/Data Source`

Pemisahan ini membuat setiap layer memiliki tanggung jawab yang jelas. Screen tidak membaca JSON secara langsung, Service tidak menangani UI, dan Provider tidak menyimpan `BuildContext` sebagai state.

### Hasil Audit

Pemeriksaan kode menunjukkan bahwa penggunaan `rootBundle` dan `jsonDecode` ditemukan pada `course_service.dart`, sedangkan pencarian `BuildContext` pada folder `providers` tidak menemukan hasil. Hal ini menunjukkan bahwa kedua bagian tersebut telah mengikuti prinsip pemisahan tanggung jawab yang diharapkan.