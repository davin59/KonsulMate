import 'package:flutter/material.dart';
import '../widgets/appbar_mentor.dart';
import '../widgets/footer_mentor.dart';

class HistoryMentor extends StatelessWidget {
  final String userName;
  final String userId;
  final String? bidangKeahlian;

  const HistoryMentor({
    super.key,
    required this.userName,
    required this.userId,
    this.bidangKeahlian,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMentor(
        userName: userName,
        userId: userId,
        bidangKeahlian: bidangKeahlian,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            const Text(
              'Ini adalah halaman History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Selamat datang, $userName',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterMentor(
        currentIndex: 2, // Karena ini adalah tab History (indeks 2 setelah menghapus Pesanan)
        userName: userName,
        userId: userId,
        bidangKeahlian: bidangKeahlian,
      ),
    );
  }
}