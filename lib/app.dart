import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing_guide_flutter/auth/repositories.dart';
import 'package:healing_guide_flutter/theme/app_theme.dart';

import 'theme/theme_cubit.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.authRepository});
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(lazy: false, create: (_) => ThemeCubit()),
        ],
        child: const MainAppView(),
      ),
    );
  }
}

class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          theme: AppTheme.lightThemeData,
          darkTheme: AppTheme.darkThemeData,
          debugShowCheckedModeBanner: false,
          home: const Scaffold(body: Center()),
        );
      },
    );
  }
}
