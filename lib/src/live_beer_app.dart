import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_beer_ex/src/navigation/navigator.dart';

class LiveBeerApp extends ConsumerWidget {
  const LiveBeerApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'LiveBeer',
      routerConfig: goRouter,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    );
  }
}
