import 'dart:ui';
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

  @override
  Size get preferredSize => const Size.fromHeight(85); // Pendekkan tinggi appbar

  Future<String> _getAsalKampus() async {
    if (userId == null) return asalKampus;
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
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
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          // Gradient background
          Container(
            height: preferredSize.height + 10, // Sedikit lebih pendek
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, // Gradient atas-bawah
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF80C9FF),
                  Color(0xFFFFFFFF),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
          // Glassmorphism effect
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Sedikit lebih pendek
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile photo with border
                  GestureDetector(
                    onTap: () {
                      if (userId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfilePage(
                              userName: userName,
                              userId: userId!,
                              asalKampus: kampus,
                            ),
                          ),);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User ID tidak tersedia')),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('assets/user_avatar.png'),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  // Name and campus
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 26, // Besarkan font nama
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.school_rounded, color: Color(0xFF80C9FF), size: 20),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                kampus,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18, // Besarkan font kampus
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Hapus tombol lonceng/notifikasi
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

