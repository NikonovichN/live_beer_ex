import 'package:flutter/material.dart';

class ShopsTab extends StatelessWidget {
  const ShopsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop, size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            const Text('Магазины', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Список магазинов будет здесь',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
