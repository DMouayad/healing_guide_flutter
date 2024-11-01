import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/routes/router.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/routes/routes.dart';

import 'features/auth/cubit/auth_state_cubit.dart';
import 'features/auth/models/auth_state.dart';
import 'features/localization/cubit/localization_cubit.dart';
import 'features/theme/theme_cubit.dart';

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
          BlocProvider(lazy: false, create: (_) => LocalizationCubit()),
          BlocProvider(
            create: (_) => AuthStateCubit(authRepository)..init(),
          ),
        ],
        child: BlocListener<AuthStateCubit, AuthState>(
          // This listener is added to redirect user to home screen when
          // `AuthState` is at an unventilated state
          listener: (context, state) =>
              router.pushReplacement(const HomeScreenRoute().location),
          listenWhen: (prev, current) => current.isUnauthenticated(),
          child: const MainAppView(),
        ),
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
        return BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, localeState) {
            return MaterialApp.router(
              title: 'Healing Guide',
              routerConfig: router,
              themeMode: themeMode,
              locale: localeState.locale,
              theme: AppTheme.lightThemeData,
              darkTheme: AppTheme.darkThemeData,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
