import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:live_beer_ex/src/navigation/navigator.dart';
import 'package:live_beer_ex/src/ui/molecules/buttons.dart';

import '../../../auth/state/provider.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 64, color: Colors.purple),
            const SizedBox(height: 16),
            const Text('Профиль', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Phone: ${authState.phone ?? "Не указан"}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              child: AppButton.outlined(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                  context.go(AppRouteNames.welcome.path);
                },
                child: const Text('Выйти'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
