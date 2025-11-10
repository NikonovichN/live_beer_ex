import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_beer_ex/src/navigation/navigator.dart';

import 'ui/ui.dart';

class LiveBeerApp extends ConsumerWidget {
  const LiveBeerApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'LiveBeer',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      routerConfig: goRouter,
    );
  }
}
