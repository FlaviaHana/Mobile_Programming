import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulir Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormMahasiswaPage(),
    );
  }
}

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();

  final cNama = TextEditingController();
  final cNpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();
  final cNoHp = TextEditingController();
  final cTanggalLahir = TextEditingController();
  final cJamBimbingan = TextEditingController();

  String? jenisKelamin;

  DateTime? tglLahir;
  TimeOfDay? jamBimbingan;

  @override
  void dispose() {
    cNama.dispose();
    cNpm.dispose();
    cEmail.dispose();
    cAlamat.dispose();
    cNoHp.dispose();
    cTanggalLahir.dispose();
    cJamBimbingan.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (res != null) {
      setState(() {
        tglLahir = res;
        cTanggalLahir.text = '${res.day}/${res.month}/${res.year}';
      });
    }
  }

  Future<void> _pickTime() async {
    final res = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (res != null) {
      setState(() {
        jamBimbingan = res;
        cJamBimbingan.text =
            '${res.hour.toString().padLeft(2, '0')}:${res.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _simpan() {
    if (!_formKey.currentState!.validate() ||
        cTanggalLahir.text.isEmpty ||
        cJamBimbingan.text.isEmpty ||
        jenisKelamin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data belum lengkap')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ringkasan Data'),
        content: Text(
          'Nama: ${cNama.text}\n'
          'NPM: ${cNpm.text}\n'
          'Email: ${cEmail.text}\n'
          'No HP: ${cNoHp.text}\n'
          'Jenis Kelamin: $jenisKelamin\n'
          'Alamat: ${cAlamat.text}\n'
          'Tanggal Lahir: ${cTanggalLahir.text}\n'
          'Jam Bimbingan: ${cJamBimbingan.text}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Formulir Mahasiswa')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: cNama,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Nama harus diisi' : null,
                ),
                TextFormField(
                  controller: cNpm,
                  decoration: const InputDecoration(
                    labelText: 'NPM',
                    prefixIcon: Icon(Icons.badge),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'NPM harus diisi' : null,
                ),
                TextFormField(
                  controller: cEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email (@unsika.ac.id)',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email harus diisi';
                    final ok =
                        RegExp(r'^[^@]+@unsika\.ac\.id$').hasMatch(v.trim());
                    return ok ? null : 'Gunakan email @unsika.ac.id';
                  },
                ),
                TextFormField(
                  controller: cNoHp,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Nomor HP harus diisi';
                    if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                      return 'Nomor HP hanya boleh angka';
                    }
                    if (v.length < 10) return 'Minimal 10 digit';
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Jenis Kelamin',
                    prefixIcon: Icon(Icons.people),
                  ),
                  value: jenisKelamin,
                  items: const [
                    DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                    DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                  ],
                  onChanged: (val) => setState(() => jenisKelamin = val),
                  validator: (v) =>
                      v == null ? 'Pilih jenis kelamin' : null,
                ),
                TextFormField(
                  controller: cAlamat,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    prefixIcon: Icon(Icons.home),
                  ),
                  maxLines: 3,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Alamat harus diisi' : null,
                ),
                TextFormField(
                  controller: cTanggalLahir,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Lahir',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: _pickDate,
                ),
                TextFormField(
                  controller: cJamBimbingan,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Jam Bimbingan',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  onTap: _pickTime,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _simpan,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      );
}
