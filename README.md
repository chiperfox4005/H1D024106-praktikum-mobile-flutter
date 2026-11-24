# Praktikum Pemrograman Mobile

**Fikry Mumtaz Pratama | H1D024106 | Shift KRS: E | Shift DC: G**

Repository ini berisi dokumentasi, source code, dan hasil kegiatan praktikum mata kuliah Pemrograman Mobile menggunakan Flutter. Setiap pertemuan disusun berdasarkan materi praktikum yang telah dikerjakan, mulai dari pengembangan antarmuka aplikasi, navigasi halaman, pengelolaan database, REST API, hingga implementasi helper dan integrasi API pada Flutter.

---

# Pertemuan 2

## Hasil Praktikum Pemrograman Mobile

Berikut adalah hasil tampilan aplikasi Flutter pada praktikum Pertemuan 2.

<p align="center">
  <img src="Screenshot%202026-10-28%20185553.png" width="300" alt="Hasil Praktikum Pertemuan 2">
</p>

---

# Pertemuan 3

## Routes, Side Menu, Login dan Local Storage

Pada Pertemuan 3, praktikum membahas implementasi navigasi halaman menggunakan Routes, pembuatan Side Menu, halaman Login, serta penyimpanan data lokal menggunakan Shared Preferences.

Materi yang dipelajari meliputi:
- Implementasi navigasi antarhalaman menggunakan Routes.
- Pembuatan dan penggunaan Side Menu.
- Pembuatan halaman Login.
- Penyimpanan data secara lokal menggunakan Shared Preferences.
- Pengelolaan informasi pengguna pada aplikasi.

### Dokumentasi Hasil Praktikum

<p align="center">
  <img src="Screenshot%202026-11-04%20081809.png" width="300" alt="Hasil Praktikum 3 - Screenshot 1">
  <img src="Screenshot%202026-11-04%20081816.png" width="300" alt="Hasil Praktikum 3 - Screenshot 2">
</p>

<p align="center">
  <img src="Screenshot%202026-11-04%20081828.png" width="300" alt="Hasil Praktikum 3 - Screenshot 3">
  <img src="Screenshot%202026-11-04%20081835.png" width="300" alt="Hasil Praktikum 3 - Screenshot 4">
</p>

---

# Pertemuan 4

## Operasi CRUD dengan API CodeIgniter 4

Pada Pertemuan 4, praktikum membahas pembuatan dan pengujian REST API menggunakan CodeIgniter 4 yang terhubung dengan database MySQL. Materi meliputi proses registrasi pengguna, login, serta operasi CRUD (Create, Read, Update, Delete) pada data produk.

Pengujian API dilakukan menggunakan Postman untuk memastikan setiap endpoint dapat berjalan dengan baik.

### Fitur yang Telah Diimplementasikan

- Registrasi pengguna.
- Login dan pembuatan authentication token.
- Menambahkan data produk (Create).
- Menampilkan seluruh data produk (Read).
- Menampilkan detail produk berdasarkan ID (Read).
- Mengubah data produk (Update).
- Menghapus data produk (Delete).

### Dokumentasi Hasil Praktikum

<p align="center">
  <img src="Screenshot%202026-11-11%20210500.png" width="300" alt="Pengujian API Pertemuan 4 - Screenshot 1">
  <img src="Screenshot%202026-11-11%20210938.png" width="300" alt="Pengujian API Pertemuan 4 - Screenshot 2">
</p>

<p align="center">
  <img src="Screenshot%202026-11-11%20211157.png" width="300" alt="Pengujian API Pertemuan 4 - Screenshot 3">
  <img src="Screenshot%202026-11-11%20211552.png" width="300" alt="Pengujian API Pertemuan 4 - Screenshot 4">
</p>

### Teknologi yang Digunakan

- CodeIgniter 4
- PHP
- MySQL
- Laragon
- Postman

Source code backend terdapat pada folder `toko-api` dan salinan dokumentasi praktikum terdapat pada folder `Pertemuan4`.

---

# Pertemuan 5

## Membuat Helper Modul dan Integrasi API pada Flutter

Pada Pertemuan 5, praktikum membahas pembuatan helper module untuk mempermudah pengelolaan komunikasi antara aplikasi Flutter dengan REST API. Helper digunakan agar proses HTTP Request, pengelolaan token autentikasi, dan penanganan kesalahan dapat dikelola secara terstruktur serta digunakan kembali oleh bagian aplikasi lainnya.

Praktikum ini juga mengimplementasikan Bloc sebagai penghubung antara proses pengolahan data dan kebutuhan antarmuka aplikasi.

### 1. HTTP Request Helper

Membuat helper untuk menangani komunikasi HTTP dengan REST API menggunakan package `http`.

Operasi yang diimplementasikan:
- GET untuk mengambil data dari server.
- POST untuk mengirim data ke server.
- PUT untuk memperbarui data pada server.
- DELETE untuk menghapus data dari server.

### 2. API URL Helper

Membuat `api_url.dart` untuk menyimpan alamat dasar API dan endpoint yang digunakan aplikasi.

Endpoint yang digunakan:
- Registrasi pengguna.
- Login pengguna.
- Daftar produk.
- Detail produk berdasarkan ID.

Dengan adanya helper ini, alamat endpoint dapat dikelola dalam satu tempat sehingga lebih mudah diperbarui.

### 3. App Exception Helper

Membuat `app_exception.dart` untuk menangani kesalahan ketika aplikasi melakukan komunikasi dengan server.

Jenis exception yang diimplementasikan:
- `AppException`
- `FetchDataException`
- `BadRequestException`
- `UnauthorisedException`
- `NotFoundException`

Penanganan exception membantu aplikasi mengenali jenis kesalahan berdasarkan respons yang diterima dari server.

### 4. Shared Preferences Helper

Membuat `user_info.dart` untuk mengelola penyimpanan informasi autentikasi pengguna secara lokal menggunakan Shared Preferences.

Fungsi yang diimplementasikan:
- `setToken()` untuk menyimpan authentication token.
- `getToken()` untuk mengambil token yang telah disimpan.
- `logout()` untuk menghapus token dari penyimpanan lokal.

Token digunakan sebagai informasi autentikasi ketika aplikasi mengakses endpoint yang membutuhkan otorisasi.

### 5. Bloc Module

Mengimplementasikan Bloc untuk memisahkan proses pengolahan data dari tampilan aplikasi.

Bloc yang dibuat meliputi:

- `registrasi_bloc.dart` untuk menangani proses registrasi pengguna.
- `login_bloc.dart` untuk menangani proses login dan penyimpanan token autentikasi.
- `logout_bloc.dart` untuk menangani proses logout dan penghapusan token.
- `produk_bloc.dart` untuk menangani pengambilan dan pengelolaan data produk.

### 6. Integrasi Flutter dengan REST API

Aplikasi Flutter dihubungkan dengan backend CodeIgniter 4 yang telah dibuat pada Pertemuan 4.

Integrasi yang dilakukan meliputi:
- Mengambil data produk dari REST API.
- Mengolah respons JSON dari server.
- Melakukan autentikasi pengguna melalui endpoint login.
- Menyimpan token autentikasi menggunakan Shared Preferences.
- Mengambil kembali token yang tersimpan.
- Menghapus token melalui proses logout.

### 7. Pengujian Aplikasi

Pengujian dilakukan menggunakan aplikasi Flutter pada Windows Desktop.

Pengujian meliputi:

- Memastikan aplikasi berhasil mengambil data produk dari API.
- Memastikan respons server dapat ditampilkan pada aplikasi.
- Memastikan proses login berhasil.
- Memastikan authentication token berhasil diterima dan disimpan.
- Memastikan token tetap tersedia setelah aplikasi dijalankan kembali.
- Memastikan proses logout menghapus token yang tersimpan.

### Dokumentasi Hasil Praktikum

<p align="center">
  <img src="Screenshot%202026-11-24%20203605.png" width="300" alt="Hasil Praktikum 5 - Screenshot 1">
  <img src="Screenshot%202026-11-24%20203853.png" width="300" alt="Hasil Praktikum 5 - Screenshot 2">
  <img src="Screenshot%202026-11-24%20204007.png" width="300" alt="Hasil Praktikum 5 - Screenshot 3">
</p>

### Struktur Folder Pertemuan 5

```text
Pertemuan5/
├── helpers/
│   ├── api.dart
│   ├── api_url.dart
│   ├── app_exception.dart
│   └── user_info.dart
│
├── bloc/
│   ├── registrasi_bloc.dart
│   ├── login_bloc.dart
│   ├── logout_bloc.dart
│   └── produk_bloc.dart
│
├── test_api.dart
└── test_auth.dart
```

File implementasi utama juga tersedia di dalam folder `lib/` agar dapat digunakan langsung oleh proyek Flutter.

### Teknologi dan Package yang Digunakan

- Flutter
- Dart
- CodeIgniter 4
- PHP
- MySQL
- Laragon
- HTTP (`http`)
- Shared Preferences (`shared_preferences`)
- Bloc

### Perintah Pengujian

Menjalankan pengujian integrasi API:

```bash
flutter run -d windows -t lib/test_api.dart
```

Menjalankan pengujian autentikasi dan token:

```bash
flutter run -d windows -t lib/test_auth.dart
```

---

# Teknologi Utama Repository

| Teknologi | Kegunaan |
|---|---|
| Flutter | Pengembangan aplikasi mobile |
| Dart | Bahasa pemrograman Flutter |
| CodeIgniter 4 | Pengembangan REST API |
| PHP | Bahasa pemrograman backend |
| MySQL | Pengelolaan database |
| Laragon | Lingkungan pengembangan lokal |
| Postman | Pengujian REST API |
| HTTP | Komunikasi aplikasi dengan API |
| Shared Preferences | Penyimpanan data lokal |
| Bloc | Pengelolaan proses dan data aplikasi |

---

**Repository ini dikembangkan sebagai dokumentasi dan tempat penyimpanan source code setiap kegiatan praktikum Pemrograman Mobile tahun 2026.**
