import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Keeper',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Map<String, String>> recipes = [];

  final List<String> categories = [
    "Makanan Ringan",
    "Makanan Berat",
    "Minuman",
    "Dessert",
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildHomePage(),
      AddRecipeForm(
        categories: categories,
        onAdd: (recipe) {
          setState(() => recipes.add(recipe));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Resep berhasil ditambahkan!"),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Keeper"),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Tambah Resep"),
        ],
      ),
    );
  }

  Widget buildHomePage() {
    if (recipes.isEmpty) {
      return const Center(
        child: Text("Belum ada resep, silakan tambah resep!"),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          elevation: 3,
          child: ListTile(
            leading: recipe["image"] != null && recipe["image"]!.isNotEmpty
                ? Image.network(
                    recipe["image"]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 60, color: Colors.grey);
                    },
                  )
                : const Icon(Icons.restaurant_menu, size: 60),
            title: Text(recipe["name"] ?? ""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe["category"] ?? ""),
                Text(recipe["description"] ?? ""),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() => recipes.removeAt(index));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Resep berhasil dihapus!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class AddRecipeForm extends StatefulWidget {
  final List<String> categories;
  final Function(Map<String, String>) onAdd;

  const AddRecipeForm({
    super.key,
    required this.categories,
    required this.onAdd,
  });

  @override
  State<AddRecipeForm> createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  String? category;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nama Resep",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Nama resep wajib diisi";
                if (value.length < 3) return "Nama resep minimal 3 karakter";
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: category,
              items: widget.categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => category = value),
              decoration: const InputDecoration(
                labelText: "Kategori",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Kategori wajib dipilih";
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Deskripsi",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) return "Deskripsi wajib diisi";
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: "URL Gambar (opsional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onAdd({
                      "name": nameController.text,
                      "category": category!,
                      "description": descriptionController.text,
                      "image": imageController.text,
                    });
                    _formKey.currentState!.reset();
                    setState(() => category = null);
                  }
                },
                child: const Text("Tambahkan Resep"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
