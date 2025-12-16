import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/legacy.dart';

// Notifier isinya berhubungan dengan void
class MatakuliahNotifier extends StateNotifier<List<DocumentSnapshot>> {
  MatakuliahNotifier() : super([]);

  // Fungsi Menambahkan data matakuliah dari firebase
  Stream<List<DocumentSnapshot>> streamData() {
    return FirebaseFirestore.instance
        .collection('matakuliah_23312014')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  // Fungsi Menambahkan data dari appnya diambil dari firebase
  Future<void> addMatakuliah(
    String kode_mk,
    String nama_mk,
    String sks,
    String sifat,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('matakuliah_23312014').add(
        {'kode_mk': kode_mk, 'nama_mk': nama_mk, 'sifat': sifat, 'sks': sks,},
      ); // diatas ini bagian kiri tulisan npm dll diambil dari field di firebase dan yang sebelah kanan npm dll ini itu adalah sebuah variabel
    } on Exception catch (e) {
      // TODO
      print(
        "error input data matakuliah: $e",
      ); // cara untuk ini yakni menggunakan refactor dengan blok sampai titik koma klik kanan dan pilih refactor kemudian pilih catch
    }
  }

  // Fungsi Delete Data Matakuliah
  Future<void> deleteMatakuliah(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('matakuliah_23312014')
          .doc(id)
          .delete();
    } on Exception catch (e) {
      // TODO
      print('error delete data matakuliah : $e');
    }
  }
}

// Provider untuk mengambil data
final MatakuliahProvider =
    StateNotifierProvider<MatakuliahNotifier, List<DocumentSnapshot>>(
      (ref) => MatakuliahNotifier(),
    );
