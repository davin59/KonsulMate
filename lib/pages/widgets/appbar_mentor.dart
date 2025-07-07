// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../mentor/profilepage_mentor.dart';
import 'dart:ui';

class AppBarMentor extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? bidangKeahlian;
  final String? userId;

  const AppBarMentor({
    super.key,
    required this.userName,
    this.bidangKeahlian,
    this.userId,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100); // Kurangi tinggi appbar

  Future<String> _getBidangKeahlian() async {
    if (userId == null) return bidangKeahlian ?? '';

    try {
      final doc = await FirebaseFirestore.instance.collection('mentors').doc(userId).get();
      if (doc.exists) {
        return doc['keahlian'] ?? bidangKeahlian ?? '';
      }
    } catch (e) {
      debugPrint('Error getting mentor data: $e');
    }
    return bidangKeahlian ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getBidangKeahlian(),
      builder: (context, snapshot) {
        String keahlian = snapshot.data ?? bidangKeahlian ?? 'Mentor';
        return _buildAppBar(context, keahlian);
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String keahlian) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          // Gradient background
          Container(
            height: preferredSize.height + 20,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF80C9FF),
                  Color(0xFFB6E0FE),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                            builder: (context) => ProfileMentor(
                              userName: userName,
                              userId: userId!,
                              bidangKeahlian: keahlian,
                            ),
                          ),
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
                        backgroundImage: AssetImage('assets/mentor_avatar.png'),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  // Name and expertise
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.workspace_premium, color: Color(0xFF80C9FF), size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                keahlian,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
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
                  // Optionally, add a settings or notification icon
                  IconButton(
                    icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF80C9FF), size: 28),
                    onPressed: () {
                      // TODO: Implement notification action
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}