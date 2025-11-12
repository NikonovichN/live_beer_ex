import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_beer_ex/src/features/auth/ui/widgets/app_log_in_state.dart';

import 'package:live_beer_ex/src/features/features.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isGuest = ref.watch(authProvider).isGuestAuthenticated;
    return Scaffold(body: isGuest ? const AppLogInState() : const Center(child: _HomeBody()));
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.home, size: 64, color: Colors.blue),
        const SizedBox(height: 16),
        const Text('Главная', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          'Добро пожаловать в главный раздел!',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
