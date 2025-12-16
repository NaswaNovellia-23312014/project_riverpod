import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/legacy.dart';

// Notifier isinya berhubungan dengan void
class DosenNotifier extends StateNotifier<List<DocumentSnapshot>> {
  DosenNotifier() : super([]);

  // Fungsi Menambahkan data dosen dari firebase
  Stream<List<DocumentSnapshot>> streamData() {
    return FirebaseFirestore.instance
        .collection('dosen')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  // Fungsi Menambahkan data dari appnya diambil dari firebase
  Future<void> addDosen(String nidn, String nama, String prodi) async {
    try {
      await FirebaseFirestore.instance.collection('dosen').add(
        {'nidn': nidn, 'nama': nama, 'prodi': prodi},
      ); // diatas ini bagian kiri tulisan npm dll diambil dari field di firebase dan yang sebelah kanan npm dll ini itu adalah sebuah variabel
    } on Exception catch (e) {
      // TODO
      print(
        "error input data dosen: $e",
      ); // cara untuk ini yakni menggunakan refactor dengan blok sampai titik koma klik kanan dan pilih refactor kemudian pilih catch
    }
  }

  // Fungsi Delete Data Dosen
  Future<void> deleteDosen(String id) async {
    try {
      await FirebaseFirestore.instance.collection('dosen').doc(id).delete();
    } on Exception catch (e) {
      // TODO
      print('error delete data dosen : $e');
    }
  }
}

// Provider untuk mengambil data
final DosenProvider =
    StateNotifierProvider<DosenNotifier, List<DocumentSnapshot>>(
      (ref) => DosenNotifier(),
    );
