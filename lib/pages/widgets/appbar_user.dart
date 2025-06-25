import 'package:flutter/material.dart';

class AppBarUser extends StatelessWidget {
  final String userName;
  const AppBarUser({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF80C9FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Temukan Mentor Terbaikmu',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 36,
            backgroundColor: Color(0xFFD9D9D9),
            child: Icon(Icons.person, color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }
}