import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routing/router.dart';
import 'core/theme/app_theme.dart';

import 'core/database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite database eagerly during startup
  final database = AppDatabase();
  await database.customSelect('SELECT 1').get();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
      ],
      child: const CureLoopApp(),
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
