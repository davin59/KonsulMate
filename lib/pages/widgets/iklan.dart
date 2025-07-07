import 'package:flutter/material.dart';

class IklanPage extends StatelessWidget {
  const IklanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ganti path asset sesuai lokasi file gambar Anda
    final List<String> imagePaths = [
      'assets/iklan/iklan1.jpg', // Gambar 1
      'assets/iklan/iklan2.jpg', // Gambar 2
      'assets/iklan/iklan3.jpg', // Gambar 3
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Iklan Promo'),
        backgroundColor: const Color(0xFF80C9FF),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: imagePaths.length,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                imagePaths[index],
                fit: BoxFit.cover,
                height: 160,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
