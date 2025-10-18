import 'package:flutter/material.dart';

class HasilPage extends StatelessWidget {
  final String nama, npm, email, noHp, jenisKelamin, alamat, tanggalLahir, jamBimbingan;

  const HasilPage({
    super.key,
    required this.nama,
    required this.npm,
    required this.email,
    required this.noHp,
    required this.jenisKelamin,
    required this.alamat,
    required this.tanggalLahir,
    required this.jamBimbingan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Data Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama: $nama"),
                Text("NPM: $npm"),
                Text("Email: $email"),
                Text("Nomor HP: $noHp"),
                Text("Jenis Kelamin: $jenisKelamin"),
                Text("Alamat: $alamat"),
                Text("Tanggal Lahir: $tanggalLahir"),
                Text("Jam Bimbingan: $jamBimbingan"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
