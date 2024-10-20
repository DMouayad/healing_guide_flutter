import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing_guide_flutter/bloc/blocs_provider.dart';
import 'package:healing_guide_flutter/theme/app_theme.dart';

import 'theme/theme_cubit.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocsProvider(
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            themeMode: themeMode,
            theme: AppTheme.lightThemeData,
            darkTheme: AppTheme.darkThemeData,
            debugShowCheckedModeBanner: false,
            home: const Scaffold(body: Center()),
          );
        },
      ),
    );
  }
}
