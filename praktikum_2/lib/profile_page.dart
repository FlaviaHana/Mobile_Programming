import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Aplikasi: My Flutter App', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Versi: 1.0.0', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 248, 144, 192))),
            SizedBox(height: 8),
            Text('Developer: Flavia Hana', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
