// lib/second_page.dart
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Kedua")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
          child: Text("Kembali ke Halaman Utama"),
        ),
      ),
    );
  }
}
