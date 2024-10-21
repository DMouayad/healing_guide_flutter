import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:healing_guide_flutter/auth/repositories.dart';
import 'package:healing_guide_flutter/routes/router.dart';
import 'package:healing_guide_flutter/theme/app_theme.dart';

import 'auth/cubit/auth_state_cubit.dart';
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
          BlocProvider(
            lazy: false,
            create: (_) => AuthStateCubit(authRepository)..init(),
          ),
        ],
        child: const MainAppView(),
      ),
    );
  }
}

class MainAppView extends StatelessWidget {
  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          routerConfig: router,
          themeMode: themeMode,
          theme: AppTheme.lightThemeData,
          darkTheme: AppTheme.darkThemeData,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
