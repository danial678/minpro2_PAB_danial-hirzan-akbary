# 🐢 Turtle Conservation App

## 1. Deskripsi Aplikasi

Turtle Conservation App adalah aplikasi mobile untuk konservasi penyu menggunakan **Flutter** dan **Supabase**. Aplikasi ini digunakan oleh petugas konservasi pantai untuk mencatat dan mengelola data proses konservasi penyu, mulai dari pencatatan sarang, jumlah telur, data induk penyu, hingga pelepasan tukik ke laut.

Aplikasi memungkinkan petugas untuk:
- Mencatat penemuan sarang penyu di berbagai lokasi pantai
- Melacak perkembangan telur dari penjelasan hingga menetas
- Mencatat jumlah tukik (anak penyu) yang berhasil dilepas ke laut
- Mengelola data konservasi secara digital dan real-time

---

## 2. Fitur Aplikasi

| No | Fitur | Penjelasan |
|----|-------|------------|
| 1 | **Autentikasi** | Login dan Register menggunakan Supabase Auth, setiap user memiliki akun sendiri |
| 2 | **CRUD Data** | Create, Read, Update, Delete data konservasi penyu ke database Supabase |
| 3 | **Dual Theme** | Dark Mode dan Light Mode dengan toggle dinamis di AppBar |
| 4 | **Real-time Data** | Data tersimpan di cloud Supabase, bisa diakses dari device mana saja |
| 5 | **Keamanan Data** | Row Level Security (RLS) memastikan user hanya bisa melihat data miliknya sendiri |
| 6 | **Form Validasi** | Validasi input sederhana untuk memastikan data lengkap |
| 7 | **Pull to Refresh** | Tarik layar ke bawah untuk memperbarui data terbaru |

---

## 3. Widget yang Digunakan

| Widget | Fungsi dalam Aplikasi |
|--------|----------------------|
| `Scaffold` | Struktur dasar setiap halaman dengan AppBar dan body |
| `AppBar` | Bagian atas aplikasi dengan judul, tombol tema, dan logout |
| `Card` | Menampilkan setiap data konservasi dalam bentuk kartu yang menarik |
| `ListView.builder` | Menampilkan daftar data konservasi yang bisa di-scroll secara efisien |
| `TextFormField` | Input teks untuk nama penyu, lokasi, dan jumlah dengan validasi |
| `DropdownButtonFormField` | Pilihan status telur: "Belum Menetas" atau "Sudah Menetas" |
| `ElevatedButton` | Tombol utama untuk login, register, dan simpan data |
| `FloatingActionButton.extended` | Tombol mengambang untuk menambah data baru |
| `SnackBar` | Menampilkan pesan notifikasi sukses atau gagal |
| `DatePicker` | Pemilih tanggal bertelur dengan kalender |
| `RefreshIndicator` | Fitur tarik-refresh untuk memuat ulang data dari server |
| `CircleAvatar` | Menampilkan inisial huruf nama penyu dengan warna tema |
| `PopupMenuButton` | Menu titik tiga di setiap card untuk edit dan delete |
| `AlertDialog` | Dialog konfirmasi sebelum menghapus data |
| `InputDecorator` | Menampilkan tanggal yang dipilih dengan style yang rapi |
| `LinearGradient` | Background gradient biru laut untuk tema aplikasi |
