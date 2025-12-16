import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_riverpod/providers/matakuliah_provider.dart';

class MatakuliahAddScreen extends ConsumerWidget {
  // Controller untuk menampung input user
  final TextEditingController ckode_mk = TextEditingController();
  final TextEditingController cnama_mk = TextEditingController();
  final TextEditingController csks = TextEditingController();
  final TextEditingController csifat = TextEditingController();

  MatakuliahAddScreen({super.key});

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
                  "Input Data Mata Kuliah",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20),

                // ====== Field Kode MK ======
                TextFormField(
                  controller: ckode_mk,
                  decoration: InputDecoration(
                    labelText: 'Kode Mata Kuliah',
                    prefixIcon: const Icon(
                      Icons.numbers_outlined,
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
                const SizedBox(height: 16),

                // ====== Field Nama Mata Kuliah ======
                TextFormField(
                  controller: cnama_mk,
                  decoration: InputDecoration(
                    labelText: 'Nama Mata Kuliah',
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

                // ====== Field SKS ======
                TextFormField(
                  controller: csks,
                  decoration: InputDecoration(
                    labelText: 'SKS',
                    prefixIcon: const Icon(Icons.book, color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.teal),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ====== Field Sifat MK ======
                TextFormField(
                  controller: csifat,
                  decoration: InputDecoration(
                    labelText: 'Sifat',
                    prefixIcon: const Icon(
                      Icons.date_range,
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

                // ====== Tombol Simpan ======
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // Simpan data ke Firebase lewat provider
                      await ref
                          .read(MatakuliahProvider.notifier)
                          .addMatakuliah(
                            ckode_mk.text,
                            cnama_mk.text,
                            csks.text,
                            csifat.text,
                          );

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
