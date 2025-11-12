import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:live_beer_ex/src/navigation/navigator.dart';
import 'package:live_beer_ex/src/ui/ui.dart';

class AppLogInState extends StatelessWidget {
  const AppLogInState({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Stack(
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
              AppButton.primary(
                onPressed: () => context.pushNamed(AppRouteNames.login.name),
                child: const Text('Войти'),
              ),
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
    );
  }
}
