import 'package:flutter/material.dart';
// Ubah import ke widget baru
import '../widgets/appbar_mentor.dart';
import '../widgets/footer_mentor.dart';

// Hapus main function yang tidak perlu lagi
// void main() {
//   runApp(const HomepageMentor(userName: 'John Doe', userId: '12345'));
// }

class HomepageMentor extends StatelessWidget {
  final String userName;
  final String userId;
  final String? bidangKeahlian; // Tambahkan parameter ini

  const HomepageMentor({
    super.key,
    required this.userName,
    required this.userId,
    this.bidangKeahlian,
  });

  @override
  Widget build(BuildContext context) {
    // Jangan gunakan MaterialApp di sini karena ini adalah halaman, bukan aplikasi
    return MentorHomePage(
      userName: userName,
      userId: userId,
      bidangKeahlian: bidangKeahlian,
    );
  }
}

// Bagian MentorProfilePage tidak dibutuhkan lagi karena sudah ada profilepage_mentor.dart
// class MentorProfilePage extends StatelessWidget {
//   ...
// }

class MentorHomePage extends StatelessWidget {
  final String userName;
  final String userId;
  final String? bidangKeahlian; // Tambahkan parameter ini

  // Simulate whether there are any orders
  final bool hasOrders = false;

  const MentorHomePage({
    super.key,
    required this.userName,
    required this.userId,
    this.bidangKeahlian,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gunakan AppBarMentor baru
      appBar: AppBarMentor(
        userName: userName,
        userId: userId,
        bidangKeahlian: bidangKeahlian,
      ),
      body: hasOrders
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildClientCard(context),
                    // You can add more client cards or other content here
                  ],
                ),
              ),
            )
          : Center(
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/bingung.png',
                      width: 200,
                      height: 200,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        size: 200,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Belum ada pesanan yang masuk',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
      // Gunakan FooterMentor baru
      bottomNavigationBar: FooterMentor(
        currentIndex: 0,
        userName: userName,
        userId: userId,
        bidangKeahlian: bidangKeahlian,
      ),
    );
  }

  // Widget _buildClientCard tetap sama
  Widget _buildClientCard(BuildContext context) {
    // Kode yang sudah ada...
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nama Client',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2 Jam',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '14:30 20/8/2025',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Lokasi yang user pesan',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Rp.51.000',
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                  ),
                  child: const Text('Tolak'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                  ),
                  child: const Text('Ambil'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
