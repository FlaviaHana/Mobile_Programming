import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Hewan {
  String nama;
  double berat;
  String warnaBulu;

  Hewan(this.nama, this.berat, this.warnaBulu);

  void makan() {
    berat += 1;
  }

  void lari() {
    berat -= 0.5;
    if (berat < 0) berat = 0;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HewanScreen(),
    );
  }
}

class HewanScreen extends StatefulWidget {
  const HewanScreen({super.key});

  @override
  State<HewanScreen> createState() => _HewanScreenState();
}

class _HewanScreenState extends State<HewanScreen> {
  Hewan kucing = Hewan("Michi", 4.2, "Putih");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Berat Hewan"),
        backgroundColor: const Color.fromARGB(255, 234, 133, 197),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nama: ${kucing.nama}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Berat: ${kucing.berat.toStringAsFixed(1)} kg",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              "Warna Bulu: ${kucing.warnaBulu}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      kucing.makan();
                    });
                  },
                  child: const Text("Makan (+1 kg)"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      kucing.lari();
                    });
                  },
                  child: const Text("Lari (-0.5 kg)"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
