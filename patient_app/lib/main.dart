import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routing/router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CureLoopApp(),
    ),
  );
}

class CureLoopApp extends ConsumerWidget {
  const CureLoopApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'CureLoop',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
