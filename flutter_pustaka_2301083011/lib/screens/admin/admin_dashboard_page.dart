import 'package:flutter/material.dart';
import 'kelola_buku_page.dart';
import '../library_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Color(0xFFFFB6C1),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildMenuCard(
            context,
            'Kelola Buku',
            Icons.book,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KelolaBukuPage(),
              ),
            ),
          ),
          _buildMenuCard(
            context,
            'Library',
            Icons.library_books,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LibraryPage(),
              ),
            ),
          ),
          _buildMenuCard(
            context,
            'Peminjaman',
            Icons.assignment,
            () {
              // TODO: Implementasi halaman daftar peminjaman
            },
          ),
          _buildMenuCard(
            context,
            'Laporan',
            Icons.assessment,
            () {
              // TODO: Implementasi halaman laporan
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Color(0xFFFFB6C1)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
