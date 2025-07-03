// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/footer_user.dart';

class HistoryUser extends StatefulWidget {
  final String userName;
  final String userId;

  const HistoryUser({super.key, required this.userName, required this.userId});

  @override
  State<HistoryUser> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<HistoryUser> {
  List<dynamic> userOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserOrders();
  }

  Future<void> loadUserOrders() async {
    try {
      final String data = await rootBundle.loadString('assets/data/dummy.json');
      final jsonData = json.decode(data);

      // Filter pesanan berdasarkan ID user
      final List<dynamic> allOrders = jsonData['pesanan'];
      final filteredOrders =
          allOrders
              .where((order) => order['id_user'] == widget.userId)
              .toList();

      // Dapatkan data mentor untuk setiap pesanan
      for (var order in filteredOrders) {
        final mentors = jsonData['mentor'] as List;
        final mentor = mentors.firstWhere(
          (m) => m['id'] == order['id_mentor'],
          orElse: () => {'nama': 'Nama Mentor', 'prodi': 'Mata Kuliah'},
        );

        order['mentor_detail'] = mentor;
      }

      setState(() {
        userOrders = filteredOrders;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB), // putih pudar
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF80C9FF), // Biru di atas
                    Colors.white,      // Putih di bawah
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 24.0, top: 40.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'History Konsultasi',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (userOrders.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'Belum ada riwayat konsultasi',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ...userOrders.map((order) => _buildOrderCard(order)),
          ],
        ),
      ),
      bottomNavigationBar: FooterUser(
        currentIndex: 3,
        userName: widget.userName,
        userId: widget.userId,
      ),
    );
  }

  Widget _buildOrderCard(dynamic order) {
    // Tentukan warna berdasarkan status
    Color statusColor;
    Color statusBgColor;
    String statusText = order['status'] ?? 'pending';

    if (statusText == 'berhasil') {
      statusColor = Colors.green;
      statusBgColor = Colors.green.shade50;
    } else if (statusText == 'gagal') {
      statusColor = Colors.red;
      statusBgColor = Colors.red.shade50;
    } else {
      // Status pending atau lainnya
      statusColor = Colors.orange;
      statusBgColor = Colors.orange.shade50;
    }

    final mentor =
        order['mentor_detail'] ??
        {'nama': 'Nama Mentor', 'prodi': 'Mata Kuliah'};

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar mentor
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),

                const SizedBox(width: 12),

                // Info mentor
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Nama mentor
                          Expanded(
                            child: Text(
                              order['nama_mentor'] ?? 'Nama Mentor',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Status label
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusBgColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              statusText.substring(0, 1).toUpperCase() +
                                  statusText.substring(1),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Mata kuliah
                      Text(
                        mentor['prodi'] ?? 'Mata Kuliah',
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 4),

                      // Durasi dan tanggal
                      Text(
                        'Durasi Pesanan: ${order['total_meets']} jam',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                      Text(
                        'Tanggal di pesan: ${order['tanggal_pesanan']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Star rating
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                    const SizedBox(width: 8),
                    const Text(
                      '4/5',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                // Pesan lagi button or cancellation info
                if (statusText == 'gagal')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Pesanan Dibatalkan Mentor',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () {
                      // Fungsi untuk memesan lagi
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF80C9FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Pesan lagi'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
