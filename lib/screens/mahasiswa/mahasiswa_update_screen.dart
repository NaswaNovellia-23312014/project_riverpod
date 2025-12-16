import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_riverpod/providers/mahasiswa_provider.dart';

class MahasiswaUpdateScreen extends ConsumerWidget {
  final TextEditingController cNama = TextEditingController();
  final TextEditingController cNpm = TextEditingController();
  final TextEditingController cProdi = TextEditingController();

  MahasiswaUpdateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final mahasiswaAsyncValue = ref.watch(mahasiswaDataProvider(id));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Ubah Data Mahasiswa',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.grey[100],
      body: mahasiswaAsyncValue.when(
        data: (mahasiswa) {
          if (mahasiswa == null) {
            return const Center(child: Text("Data Tidak Ditemukan"));
          }

          if (cNama.text.isEmpty) {
            cNpm.text = mahasiswa['npm'];
            cNama.text = mahasiswa['nama'];
            cProdi.text = mahasiswa['prodi'];
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: cNpm,
                  decoration: const InputDecoration(
                    labelText: 'NPM',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: cNama,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: cProdi,
                  decoration: const InputDecoration(
                    labelText: 'Program Studi',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(MahasiswaProvider.notifier)
                          .updateMahasiswa(
                            id,
                            cNpm.text,
                            cNama.text,
                            cProdi.text,
                          );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Ubah",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
