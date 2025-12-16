import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_riverpod/screens/auth/login_screen.dart';
import 'package:project_riverpod/screens/home/home_screen.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: "Project Riverpod",
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    ); // Materialapp tema yang kita gunakan
  }
}




// Buka Flutter Fire
// GET STARTED => ketikan di terminal flutter pub add firebase_core 
// kemudian lanjut ketikan dart pub global activate flutterfire_cli => lalu ketikan npm install -g firebase-tools
// lalu lanjut ke flutterfire configure = proses memilih project di firebasefire = firebase login - no (gemini) - yes - lalu login
// lalu apabila sudah berhasil ketikan lagi flutterfire configure
// untuk membuat folder firebase option pertama ketikan perintah flutterfire -v (untuk mengetahui versinya) lalu lanjut ketikan flutterfire configure
// lalu pilih project dan enter -> pilih platform (android, web) cara hapusnya menggunakan spasi -> lalu enter

// lalu buka flutterfire -> CLI -> Lalu dibagian once complete kita copy : import 'firebase_options.dart';
// lalu lanjutkan lagi copy bawahnya dan pastekan bagian void main await Firebase.initializeApp(  options: DefaultFirebaseOptions.currentPlatform,);

// lalu tambahkan async 
// apabila error kita klik lampunya
// sebelum membuat folder lanjut tambahkan package (firebase_core, flutter_riverpod, cloud_firestore) menggunakan terminal -> flutter pub add nama package
// lalu kita tambahkan folder yang akan menampung user interface dan provider
// buka file main dart -> kita kosongkan dari class My App sampe bawah kita hapus -> lalu buat stless widget -> lalu ganti namanya menjadi MyApp
// 
// lalu kita akan membuat halaman home 