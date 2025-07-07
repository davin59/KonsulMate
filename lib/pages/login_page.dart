// ignore_for_file: use_build_context_synchronously

import 'dart:convert'; // Untuk mengkonversi JSON
import 'package:flutter/services.dart'
    show rootBundle; // Untuk mengambil file dari assets
import 'package:flutter/material.dart'; // Import UI toolkit Flutter
import 'user/homepage_user.dart'; // Import halaman utama untuk user
import 'mentor/homepage_mentor.dart'; // Import halaman utama untuk mentor
import 'mentor/regis_mentor.dart'; // Tambahkan import ini
import 'user/regis_user.dart'; // Tambahkan import ini
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin/dashboard_admin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController emailController =
      TextEditingController(); // Controller untuk input email
  final TextEditingController passwordController =
      TextEditingController(); // Controller untuk input password
  bool isMentorSelected =
      false; // Boolean untuk mengecek apakah login sebagai mentor atau user
      
  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _titleAnimation;
  late Animation<double> _firstTaglineAnimation;
  late Animation<double> _imageAnimation;
  late Animation<double> _secondTaglineAnimation;
  
  // Add new animations for login form
  late Animation<double> _formContainerAnimation;
  late Animation<double> _emailFieldAnimation;
  late Animation<double> _passwordFieldAnimation;
  late Animation<double> _buttonsAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller with longer duration to accommodate all animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000), // Increased duration for all animations
      vsync: this,
    );
    
    // Create a sequence of animations with different intervals
    // Title animation (0% - 50% of total duration)
    _titleAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );
    
    // First tagline animation (30% - 70% of total duration)
    _firstTaglineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );
    
    // Image animation (50% - 85% of total duration)
    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
      ),
    );
    
    // Second tagline animation (70% - 100% of total duration)
    _secondTaglineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );
    
    // Form container slides up animation (80% - 100% of total duration)
    _formContainerAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
      ),
    );
    
    // Email field fade in animation
    _emailFieldAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.85, 0.95, curve: Curves.easeOut),
      ),
    );
    
    // Password field fade in animation
    _passwordFieldAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.9, 1.0, curve: Curves.easeOut),
      ),
    );
    
    // Buttons scale animation
    _buttonsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.95, 1.0, curve: Curves.elasticOut),
      ),
    );
    
    // Start the animation sequence when the page loads
    _animationController.forward();
  }
  
  @override
  void dispose() {
    // Clean up animation controller
    _animationController.dispose();
    super.dispose();
  }

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
          builder:
              (context) =>
                  isMentorSelected
                      // Ganti MentorHomePage menjadi HomepageMentor
                      ? HomepageMentor(userName: userName, userId: userId)
                      : HomeUser(
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

  // Fungsi login dengan Firebase Auth dan cek role di Firestore
  Future<void> handleFirebaseLogin(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Login ke Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;

      // Cek di koleksi 'admin'
      DocumentSnapshot adminDoc = await FirebaseFirestore.instance
          .collection('admin')
          .doc(uid)
          .get();
      if (adminDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardAdmin(
              adminName: adminDoc['nama'] ?? 'Admin',
              adminId: uid,
            ),
          ),
        );
        return;
      }

      if (isMentorSelected) {
        // Cek di koleksi 'mentors'
        DocumentSnapshot mentorDoc = await FirebaseFirestore.instance
            .collection('mentors')
            .doc(uid)
            .get();
        if (mentorDoc.exists && mentorDoc['role'] == 'mentor') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomepageMentor(
                userName: mentorDoc['nama_lengkap'] ?? '',
                userId: uid,
              ),
            ),
          );
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Akun ini tidak terdaftar sebagai mentor!')),
          );
          return;
        }
      } else {
        // Cek di koleksi 'users'
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        if (userDoc.exists && userDoc['role'] == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeUser(
                userName: userDoc['nama_lengkap'] ?? '',
                userId: uid,
                asalKampus: userDoc['asal_kampus'] ?? '',
              ),
            ),
          );
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Akun ini tidak terdaftar sebagai user!')),
          );
          return;
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Email atau password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Bagian atas - Logo dan Tagline
            Container(
              padding: const EdgeInsets.only(
                top: 60.0,
                bottom: 20.0,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  // Animated title that slides in from the left
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                          MediaQuery.of(context).size.width * _titleAnimation.value, 
                          0, 
                          0
                        ),
                        child: const Text(
                          'KonsulMate',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'chewy',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  
                  // First tagline with fade-in effect
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _firstTaglineAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - _firstTaglineAnimation.value)),
                          child: const Text(
                            'Membantu Menemukan',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'chewy',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Image with scale animation
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _imageAnimation.value,
                        child: Opacity(
                          opacity: _imageAnimation.value,
                          child: Image.asset(
                            'assets/images/illustration.png',
                            height: 200,
                          ),
                        ),
                      );
                    },
                  ),
                  
                  // Second tagline with fade-in effect
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _secondTaglineAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - _secondTaglineAnimation.value)),
                          child: const Text(
                            'Mentor Terbaikmu',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'chewy',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Animated form container
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, MediaQuery.of(context).size.height * 0.2 * _formContainerAnimation.value),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF87CEEB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        // Custom toggle button for login type selection
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Stack(
                            children: [
                              // Animated blue background that slides
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                left: isMentorSelected ? 0 : MediaQuery.of(context).size.width / 2 - 20,
                                top: 0,
                                bottom: 0,
                                width: MediaQuery.of(context).size.width / 2 - 20,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.elasticOut, // Spring-like effect for natural movement
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.blue.shade600, Colors.blue.shade800],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // The two toggle buttons
                              Row(
                                children: [
                                  // Mentor login button
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!isMentorSelected) {
                                          setState(() {
                                            isMentorSelected = true;
                                          });
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeOutCubic,
                                        transform: Matrix4.identity()
                                          ..scale(isMentorSelected ? 1.05 : 1.0),
                                        alignment: Alignment.center,
                                        color: Colors.transparent,
                                        child: Text(
                                          'Login Mentor',
                                          style: TextStyle(
                                            color: isMentorSelected ? Colors.white : Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMentorSelected ? 16.5 : 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // User login button
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isMentorSelected = false;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.transparent,
                                        child: Text(
                                          'Login User',
                                          style: TextStyle(
                                            color: !isMentorSelected ? Colors.white : Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Animated email input field
                        const SizedBox(height: 20),
                        FadeTransition(
                          opacity: _emailFieldAnimation,
                          child: TextField(
                            controller: emailController,
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
                        ),
                        
                        const SizedBox(height: 15),
                        // Animated password input field
                        FadeTransition(
                          opacity: _passwordFieldAnimation,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
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
                        ),
                        
                        const SizedBox(height: 20),
                        // Animated buttons
                        ScaleTransition(
                          scale: _buttonsAnimation,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (isMentorSelected) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => const RegisterMentorScreen(),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => const RegisterUserScreen(),
                                        ),
                                      );
                                    }
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
                                    // Ganti handleMasuk(context) menjadi handleFirebaseLogin(context)
                                    handleFirebaseLogin(context);
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}