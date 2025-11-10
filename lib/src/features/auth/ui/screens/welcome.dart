import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_beer_ex/src/navigation/navigator.dart';

import 'package:vector_graphics/vector_graphics_compat.dart';

import '../../../../ui/ui.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: fix inner padding of page
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.backgroundWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 506),
              child: Stack(
                children: [
                  // TODO: add path generator
                  Positioned.fill(child: Image.asset('assets/images/beer_background.png')),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 32.0 + MediaQuery.of(context).padding.top,
                    child: Column(
                      children: [
                        VectorGraphic(loader: AssetBytesLoader('assets/svg/logo.svg')),
                        const SizedBox(height: 9.0),
                        Container(
                          color: AppColors.darkNight,
                          padding: const EdgeInsets.all(2.0),
                          child: VectorGraphic(
                            loader: AssetBytesLoader('assets/svg/market_name.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 10.0,
                    child: Image.asset('assets/images/hands.png'),
                  ),
                ],
              ),
            ),

            // TODO: add translations
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Программа лояльности для клиентов LiveBeer',
                    textAlign: TextAlign.center,
                    style: TextTheme.of(
                      context,
                    ).displaySmall?.copyWith(height: 1.2, fontSize: 32.0),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton.primary(
                          onPressed: () => context.goNamed(AppRouteNames.login.name),
                          child: const Text('Вход'),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: AppButton.primary(
                          onPressed: () {},
                          child: const Text('Регистрация'),
                        ),
                      ),
                    ],
                  ),
                  AppButton.outlined(
                    onPressed: () {},
                    margin: EdgeInsets.all(0.0),
                    child: const Text('Вход без регистрации'),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
