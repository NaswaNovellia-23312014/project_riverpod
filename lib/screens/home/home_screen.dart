
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_riverpod/providers/home_providers.dart';
import 'package:project_riverpod/screens/dashboard_screen.dart';
import 'package:project_riverpod/screens/dosen/dosen_add_screen.dart';
import 'package:project_riverpod/screens/dosen/dosen_screen.dart';
import 'package:project_riverpod/screens/mahasiswa/mahasiswa_add_screen.dart';
import 'package:project_riverpod/screens/mahasiswa/mahasiswa_screen.dart';
import 'package:project_riverpod/screens/matakuliah/matakuliah_add_screen.dart';
import 'package:project_riverpod/screens/matakuliah/matakuliah_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeController = ref.watch(HomeProvider);

    return DashboardAdmin();
  }
}

// menampilkan bagian awal
final indexProvider = StateProvider((ref) => 0);

class DashboardAdmin extends ConsumerWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // akan membuat halaman menggunakan index
    final _index = ref.watch(indexProvider);

    // membuat fragment -> misal klik menu dosen akan tampil semua datanya yang sesuai
    List<Map> _fragment = [
      {
        'title': 'Halaman Utama',
        'view': DashboardScreen(),
        'add': MahasiswaAddScreen(),
      },
      {
        'title': 'Data Mahasiswa',
        'view': MahasiswaScreen(),
        'add': MahasiswaAddScreen(),
      },
      {'title': 'Data Dosen', 'view': DosenScreen(), 'add': DosenAddScreen()},
      {
        'title': 'Data Mata Kuliah',
        'view': MatakuliahScreen(),
        'add': MatakuliahAddScreen(),
      },
    ];

    return Scaffold(
      // membuat appbar/header atas
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          // ini nantinya akan sesuai yang diklik oleh user antara dua pilihan dari title diatas
          _fragment[_index]['title'],
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,

        // MENAMBAHKAN TOMBOL TAMBAH
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _fragment[_index]['add'],
                ),
              );
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),

      // body
      body: _fragment[_index]['view'],
      drawer: drawer(ref, context),
    );
  }

  // membuat fitur menu yang disamping atau burger menu
  Widget drawer(WidgetRef ref, BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.account_circle, size: 80, color: Colors.white),
                Text(
                  "Naswa Novellia",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Prodi Informatika',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              // membaca state ke 0
              ref.read(indexProvider.notifier).state = 0;
              Navigator.pop(context);
            },
            leading: Icon(Icons.home),
            title: Text("Halaman Utama"),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.teal,
            textColor: Colors.teal,
          ),
          ListTile(
            onTap: () {
              // membaca state ke 1
              ref.read(indexProvider.notifier).state = 1;
              Navigator.pop(context);
            },
            leading: Icon(Icons.people_outlined),
            title: Text("Mahasiswa"),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.teal,
            textColor: Colors.teal,
          ),
          ListTile(
            onTap: () {
              // membaca state ke 2
              ref.read(indexProvider.notifier).state = 2;
              Navigator.pop(context);
            },
            leading: Icon(Icons.people_alt_rounded),
            title: Text("Dosen"),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.teal,
            textColor: Colors.teal,
          ),
          ListTile(
            onTap: () {
              // membaca state ke 2
              ref.read(indexProvider.notifier).state = 3;
              Navigator.pop(context);
            },
            leading: Icon(Icons.book_sharp),
            title: Text("Mata Kuliah"),
            trailing: Icon(Icons.navigate_next),
            iconColor: Colors.teal,
            textColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
