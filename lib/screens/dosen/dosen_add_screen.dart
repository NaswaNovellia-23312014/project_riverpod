import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_riverpod/providers/dosen_provider.dart';

class DosenAddScreen extends ConsumerWidget {
  // Controller untuk menampung input user
  final TextEditingController cNama = TextEditingController();
  final TextEditingController cNidn = TextEditingController();
  final TextEditingController cFakultas = TextEditingController();
  final TextEditingController cProdi = TextEditingController();

  DosenAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // ====== AppBar dengan warna teal ======
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Tambah Data',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
      ),

      // ====== Background lembut dengan padding ======
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),

            // ====== Form input data ======
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Input Data Dosen",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20),

                // ====== Field Nama ======
                TextFormField(
                  controller: cNama,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    prefixIcon: const Icon(Icons.person, color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ====== Field NIDN ======
                TextFormField(
                  controller: cNidn,
                  decoration: InputDecoration(
                    labelText: 'NIDN',
                    prefixIcon: const Icon(
                      Icons.credit_card,
                      color: Colors.teal,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // ====== Field Fakultas ======
                TextFormField(
                  controller: cProdi,
                  decoration: InputDecoration(
                    labelText: 'Fakultas',
                    prefixIcon: const Icon(
                      Icons.houseboat_outlined,
                      color: Colors.teal,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // ====== Field Program Studi ======
                TextFormField(
                  controller: cProdi,
                  decoration: InputDecoration(
                    labelText: 'Program Studi',
                    prefixIcon: const Icon(Icons.school, color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // ====== Tombol Simpan ======
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // Simpan data ke Firebase lewat provider
                      await ref
                          .read(DosenProvider.notifier)
                          .addDosen(cNidn.text, cNama.text, cProdi.text);

                      // Notifikasi berhasil
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Data berhasil ditambahkan!"),
                          backgroundColor: Colors.teal,
                        ),
                      );

                      // Kembali ke halaman sebelumnya
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      "Simpan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
