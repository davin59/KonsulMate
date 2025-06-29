// ignore_for_file: use_build_context_synchronously

import 'dart:convert'; // Untuk mengkonversi JSON
import 'package:flutter/services.dart'
    show rootBundle; // Untuk mengambil file dari assets
import 'package:flutter/material.dart'; // Import UI toolkit Flutter
import 'package:flutter_application_1/pages/mentor/homepage_mentor.dart' show MentorHomePage;
import 'user/user_home_page.dart'; // Import halaman utama untuk user
import 'mentor/homepage_mentor.dart'; // Import halaman utama untuk mentor

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =
      TextEditingController(); // Controller untuk input email
  final TextEditingController passwordController =
      TextEditingController(); // Controller untuk input password
  bool isMentorSelected =
      false; // Boolean untuk mengecek apakah login sebagai mentor atau user

  // Fungsi untuk memuat data dari file JSON lokal
  Future<Map<String, dynamic>> loadJsonData() async {
    String data = await rootBundle.loadString(
      'assets/data/dummy.json',
    ); // Membaca file JSON dari assets
    return json.decode(data); // Mengubah string JSON menjadi Map
  }

  // Fungsi ketika tombol Masuk ditekan
  void handleMasuk(BuildContext context) async {
    String email = emailController.text.trim(); // Ambil email dari input
    String password =
        passwordController.text.trim(); // Ambil password dari input
    final jsonData = await loadJsonData(); // Memuat data JSON

    String role =
        isMentorSelected
            ? 'mentor'
            : 'user'; // Menentukan role berdasarkan pilihan
    final dataList = jsonData[role] as List; // Ambil list user/mentor dari JSON
    final user = dataList.firstWhere(
      (u) =>
          u['email'] == email &&
          u['password'] ==
              password, // Cari user dengan email dan password sesuai
      orElse: () => null, // Jika tidak ditemukan, kembalikan null
    );

    if (user != null) {
      // Jika user ditemukan, arahkan ke halaman sesuai role
  final String userName = user['nama'] ?? '';
  final String userId = user['id'] ?? '';
  
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => isMentorSelected
          ? const MentorHomePage() 
          : UserHomePage(
            userName: userName,
            userId: userId,
            ), // Kirim nama user yang sesuai
    ),
  );
    } else {
      // Jika user tidak ditemukan, tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Atur latar belakang menjadi putih
      body: SingleChildScrollView(
        // Supaya bisa discroll jika layar kecil
        child: Column(
          children: <Widget>[
            // Bagian atas - Logo dan Tagline
            Container(
              padding: const EdgeInsets.only(
                top: 60.0,
                bottom: 20.0,
              ), // Padding atas dan bawah
              color: Colors.white,
              child: Column(
                children: [
                  const Text(
                    'KonsulMate', // Nama aplikasi
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'chewy',
                    ),
                  ),
                  const SizedBox(height: 10), // Spasi
                  const Text(
                    'Membantu Menemukan', // Tagline
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'chewy',
                    ),
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/illustration.png',
                    height: 200,
                  ), // Gambar ilustrasi
                  const Text(
                    'Mentor Terbaikmu', // Lanjutan tagline
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'chewy',
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Bagian bawah - Form Login
            Container(
              width: double.infinity, // Lebar penuh
              padding: const EdgeInsets.all(20.0), // Padding isi
              decoration: const BoxDecoration(
                color: Color(0xFF87CEEB), // Warna latar biru muda
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),

              // Pilihan login sebagai user atau mentor
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // Rata seimbang
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isMentorSelected =
                                  true; // Pilih login sebagai mentor
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isMentorSelected
                                    ? Colors.blue[900] // Warna jika dipilih
                                    : Colors
                                        .blue[400], // Warna jika tidak dipilih
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Login Mentor', // Teks tombol
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isMentorSelected =
                                  false; // Pilih login sebagai user
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                !isMentorSelected
                                    ? Colors.blue[900]
                                    : Colors.blue[400],
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Login User',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Kolom input email dan password
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController, // Input email
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordController, // Input password
                    obscureText: true, // Agar tidak terlihat
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tombol daftar dan masuk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Fungsi saat tombol daftar ditekan (belum diimplementasi)
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800], // Warna tombol
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            handleMasuk(context); // Panggil fungsi login
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    'Sign in with another method', // Teks login alternatif
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 15),

                  // Ikon login alternatif (dummy)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.email,
                          size: 30,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          // login email 
                        },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(
                          Icons.facebook,
                          size: 30,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          // Login Facebook
                        },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(
                          Icons.travel_explore,
                          size: 30,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: () {
                          // login Twitter 
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
