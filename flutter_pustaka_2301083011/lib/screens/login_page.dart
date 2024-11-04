import 'package:flutter/material.dart';
import '../screens/user/peminjaman_page.dart';
import '../screens/admin/admin_dashboard_page.dart';
import '../widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFB5C5), // Pink pastel yang lebih gelap
              Color(0xFFFFCBDB), // Pink pastel medium
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.library_books,
                size: 100, color: Color(0xFFFF4D82)), // Pink yang lebih gelap
            const SizedBox(height: 20),
            const Text(
              'SISTEM PERPUSTAKAAN',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A4A4A), // Warna teks diubah ke abu-abu gelap
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomButton(
                        text: 'User',
                        color: Color(0xFFB5E5CF), // Mint pastel
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PeminjamanPage(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Admin',
                        color: Color(0xFFFFB5E8), // Pink pastel
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminDashboardPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
