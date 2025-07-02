import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../user/profilepage_user.dart';

class AppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String asalKampus;
  final String? userId;
  const AppBarUser({
    super.key,
    required this.userName,
    this.asalKampus = "Asal Kampus",
    this.userId,
  });

  Future<String> _getAsalKampus() async {
    if (userId == null) return asalKampus;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return doc.data()?['asal_kampus'] ?? asalKampus;
  }

  @override
  Widget build(BuildContext context) {
    // Jika asalKampus sudah diisi dari parent, tampilkan langsung
    if (asalKampus != "Asal Kampus" && asalKampus.isNotEmpty) {
      return _buildAppBar(context, asalKampus);
    }
    // Jika tidak, ambil dari Firestore berdasarkan userId
    return FutureBuilder<String>(
      future: _getAsalKampus(),
      builder: (context, snapshot) {
        final kampus = snapshot.data ?? asalKampus;
        return _buildAppBar(context, kampus);
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String kampus) {
    return AppBar(
      backgroundColor: const Color(0xFF80C9FF),
      elevation: 0,
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            kampus,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfilePage(),
                ),
              );
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/mentor_avatar.png'),
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
