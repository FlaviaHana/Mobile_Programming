import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'input_mahasiswa_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Navigation',
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, String>? mahasiswa;
  String? nomorTelepon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Page")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: const Text("Go to Profile Page"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InputMahasiswaPage(),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      mahasiswa = {
                        "nama": result['nama'],
                        "umur": result['umur'],
                        "alamat": result['alamat'],
                        "kontak": result['kontak'],
                      };
                      nomorTelepon = result['kontak'];
                    });
                  }
                },
                child: const Text("Input Mahasiswa"),
              ),
              const SizedBox(height: 24),
              if (mahasiswa != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama: ${mahasiswa!['nama']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Umur: ${mahasiswa!['umur']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Alamat: ${mahasiswa!['alamat']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Kontak: ${mahasiswa!['kontak']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              if (nomorTelepon != null)
                ElevatedButton(
                  onPressed: () async {
                    final Uri telUri = Uri(scheme: 'tel', path: nomorTelepon);
                    if (await canLaunchUrl(telUri)) {
                      await launchUrl(telUri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Tidak bisa membuka aplikasi telepon"),
                        ),
                      );
                    }
                  },
                  child: const Text("Call"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}