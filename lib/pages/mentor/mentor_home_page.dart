import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentor App UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MentorHomePage(),
    );
  }
}

// Define the MentorProfilePage
class MentorProfilePage extends StatelessWidget {
  const MentorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor Profile'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white, // Text and icon color
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    'assets/mentor_avatar.png'), // Use mentor's avatar
                backgroundColor: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                'Nama Mentor',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Asal Kampus',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              // Add more profile details here
              Text(
                'Detail informasi tentang mentor akan ditampilkan di sini. '
                'Ini bisa mencakup keahlian, pengalaman, dan kontak.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MentorHomePage extends StatelessWidget {
  const MentorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
        toolbarHeight: 80, // Adjust height as needed
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Mentor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Asal Kampus',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector( // Wrapped with GestureDetector
              onTap: () {
                // Navigate to MentorProfilePage when mentor's avatar is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MentorProfilePage()),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: const AssetImage(
                    'assets/mentor_avatar.png'), // Replace with your image asset
                backgroundColor: Colors.grey, // Placeholder if image not found
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '', // Empty label to mimic the image
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '', // Empty label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: '', // Empty label
          ),
        ],
        currentIndex: 1, // Highlight home icon as per image
        onTap: (index) {
          // Handle navigation for bottom bar
          // For example:
          // if (index == 0) {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
          // }
        },
      ),
    );
  }

  Widget _buildClientCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: const AssetImage(
                      'assets/client_avatar.png'), // Replace with your image asset
                  backgroundColor: Colors.blueGrey, // Placeholder
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
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '14:30 20/8/2025',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Lokasi yang user pesahn', // Typo from image "pesahn"
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  onPressed: () {
                    // Handle Tolak action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                  ),
                  child: const Text('Tolak'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle Ambil action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
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
