import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/live_beer_app.dart';
import 'src/utils/utils.dart';

void main() {
  runZonedGuarded(
    () => runApp(const ProviderScope(child: LiveBeerApp())),
    (e, stt) => logger.e(e, stackTrace: stt),
  );
}
