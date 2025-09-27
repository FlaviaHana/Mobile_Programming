import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Berita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewsListPage(),
    );
  }
}

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  final List<Map<String, String>> newsData = const [
    {
      "title": "Pulau Seribu",
      "subtitle": "Pulau Seribu menawarkan pesona pantai indah dan laut jernih, menjadi destinasi favorit wisatawan sekaligus fokus pengembangan wisata berkelanjutan Jakarta.",
      "image": "https://www.jakarta.go.id/uploads/contents/content--20210324094944.jpg"
    },
    {
      "title": "Makanan Khas Palembang",
      "subtitle": "Pempek adalah makanan khas Palembang berbahan dasar ikan dan sagu, disajikan dengan kuah cuka asam manis pedas yang khas.",
      "image": "https://cdn.rri.co.id/berita/Tarakan/o/1720401369943-WhatsApp_Image_2024-07-08_at_09.15.53/te4o3qu540mdcro.jpeg"
    },
    {
      "title": "Manfaat Buah Strawberry",
      "subtitle": "Stroberi kaya vitamin C, serat, dan antioksidan yang bermanfaat untuk menjaga daya tahan tubuh, menyehatkan kulit, serta membantu menjaga kesehatan jantung.",
      "image": "https://res.cloudinary.com/dk0z4ums3/image/upload/v1624248302/attached_image/Manisnya-Manfaat-Strawberry-Ternyata-Ada-Banyak.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Berita"),
      ),
      body: ListView.builder(
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          final news = newsData[index];
          return ListTile(
            leading: news["image"]!.startsWith("http")
                ? Image.network(
                    news["image"]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    news["image"]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
            title: Text(news["title"]!),
            subtitle: Text(news["subtitle"]!),
            trailing: const Icon(Icons.bookmark_border),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Mengalihkan ke halaman berita"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
