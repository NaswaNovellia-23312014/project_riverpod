import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_riverpod/providers/mahasiswa_provider.dart';
import 'package:project_riverpod/screens/mahasiswa/mahasiswa_update_screen.dart';

// Widget utama untuk menampilkan daftar mahasiswa
class MahasiswaScreen extends ConsumerWidget {
  const MahasiswaScreen({super.key});

  // Fungsi untuk menampilkan dialog pilihan (Update / Delete / Tutup)
  void showOption(BuildContext context, String id, WidgetRef ref) async {
    await showDialog(
      context: context,
      builder:
          (context) => SimpleDialog(
            // Bentuk dialog dibulatkan agar terlihat lebih lembut
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              'Pilih Aksi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              // Opsi Update Data
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Update'),
                onTap: () {
                  ref.read(mahasiswaDataProvider(id));
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MahasiswaUpdateScreen(),
                      settings: RouteSettings(arguments: id),
                    ),
                  );
                },
              ),

              // Opsi Delete Data
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context); // Tutup dialog utama
                  _showConfirmDelete(
                    context,
                    id,
                    ref,
                  ); // Panggil dialog konfirmasi
                },
              ),

              // Tombol untuk menutup dialog
              ListTile(
                leading: const Icon(Icons.close, color: Colors.grey),
                title: const Text('Tutup'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi sebelum data dihapus
  void _showConfirmDelete(BuildContext context, String id, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            // Sudut dialog dibuat melengkung agar tampilan lebih halus
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Konfirmasi Hapus'),
            content: const Text('Apakah kamu yakin ingin menghapus data ini?'),

            // Tombol aksi di bagian bawah dialog
            actions: [
              // Tombol batal, hanya menutup dialog
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),

              // Tombol hapus yang benar-benar melakukan penghapusan
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    // Jalankan fungsi delete dari provider
                    await ref
                        .read(MahasiswaProvider.notifier)
                        .deleteMahasiswa(id);

                    // Tutup dialog konfirmasi
                    Navigator.pop(context);

                    // Tampilkan snackbar sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Data berhasil dihapus'),
                        backgroundColor: Colors.teal,
                      ),
                    );
                  } catch (e) {
                    // Jika terjadi error, tampilkan snackbar merah
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal menghapus data: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.delete_forever),
                label: const Text('Hapus'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
    );
  }

  // Tampilan utama layar daftar mahasiswa
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // Body berisi StreamBuilder yang memantau data dari Firestore
      body: StreamBuilder<List<DocumentSnapshot>>(
        // Memanggil stream dari provider
        stream: ref.read(MahasiswaProvider.notifier).streamData(),
        builder: (context, snapshot) {
          // Jika koneksi sudah aktif dan data sudah diterima
          if (snapshot.connectionState == ConnectionState.active) {
            // Ambil semua dokumen dari snapshot
            var listAllDocs = snapshot.data ?? [];

            // Jika ada data, tampilkan dalam bentuk ListView
            return listAllDocs.isNotEmpty
                ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: listAllDocs.length,
                  itemBuilder: (context, index) {
                    // Ambil data dari masing-masing dokumen
                    var data =
                        listAllDocs[index].data() as Map<String, dynamic>;

                    // Setiap item ditampilkan dalam bentuk Card agar lebih elegan
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2, // efek bayangan lembut
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        // Avatar lingkaran di sebelah kiri (nomor urut)
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal.shade100,
                          child: Text('${index + 1}'),
                        ),

                        // Nama mahasiswa sebagai judul utama
                        title: Text(
                          data["nama"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        // NPM dan Prodi ditampilkan di bawah nama
                        subtitle: Text(
                          'NPM: ${data["npm"]}\nProdi: ${data["prodi"]}',
                        ),
                        isThreeLine: true, // supaya tinggi menyesuaikan 3 baris
                        // Tombol titik tiga di sebelah kanan (opsi)
                        trailing: IconButton(
                          onPressed:
                              () => showOption(
                                context,
                                listAllDocs[index].id,
                                ref,
                              ),
                          icon: const Icon(Icons.more_vert),
                        ),
                      ),
                    );
                  },
                )
                // Jika data kosong, tampilkan teks informasi
                : const Center(
                  child: Text(
                    "Belum ada data mahasiswa",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                );
          }

          // Jika masih memuat data, tampilkan loading spinner
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
