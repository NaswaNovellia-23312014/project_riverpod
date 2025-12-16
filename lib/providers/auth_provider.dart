import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<User?> {
  // variabel _auth ini digunakan untuk mempersingkat code irebaseAuth.instance yang dimana apabila kita ingin memanggil firebaseauth.instance ini menggunakan _auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthNotifier() : super(null) {
    _auth.authStateChanges().listen((user) {
      state = user;
    });
  }

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  // Fungsi untuk login
  Future<String?> login(String email, String pass) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      // return null; // null = sukses

      // berfungsi untuk
      if (credential.user!.emailVerified) {
        return null;
      } else {
        return "Harap Verifikasi Email Terlebih Dahulu!";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Email tidak ditemukan.";
      } else if (e.code == 'wrong-password') {
        return "Password salah.";
      } else {
        return e.message;
      }
    }
  }

  Future<String?> signup(String email, String password) async {
    try {
      UserCredential myUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await myUser.user!.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Password terlalu lemah.";
      } else if (e.code == 'email-already-in-use') {
        return "Email sudah terdaftar.";
      } else {
        return e.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(),
);
