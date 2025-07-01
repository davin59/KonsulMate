import 'package:flutter/material.dart';
import '../user/profilepage_user.dart';

class AppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String asalKampus;
  const AppBarUser({
    super.key,
    required this.userName,
    this.asalKampus = "Asal Kampus",
  });

  @override
  Widget build(BuildContext context) {
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
            asalKampus,
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
                  builder:
                      (context) =>
                          const UserProfilePage(), // gunakan UserProfilePage
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
