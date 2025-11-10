import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_beer_ex/src/ui/ui.dart';

import '../../state/provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // TODO: do not forget
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  // void _login() {
  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text.trim();

  //   if (email.isNotEmpty && password.isNotEmpty) {
  //     ref.read(authProvider.notifier).login(email, password);
  //   } else {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Заполните все поля')));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 0.0, child: Image.asset('assets/images/beer_background.png')),
          Positioned(
            left: 32.0,
            top: MediaQuery.of(context).padding.top + 106.0,
            right: 32.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Войдите в приложение',
                  style: textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Чтобы копить баллы и литры, вам надо авторизироваться в приложении',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                AppButton.primary(onPressed: () {}, child: const Text('Войти')),
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: -10.0,
            right: 0.0,
            child: Image.asset('assets/images/beer_glasses.png'),
          ),
        ],
      ),
    );
  }
}
