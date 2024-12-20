import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:healing_guide_flutter/features/auth/cubit/auth_state_cubit.dart';
import 'package:healing_guide_flutter/features/auth/models/auth_state.dart';
import 'package:healing_guide_flutter/features/localization/cubit/localization_cubit.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/features/theme/theme_cubit.dart';
import 'package:healing_guide_flutter/routes/routes.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const divider = Divider(color: AppTheme.dividerColor);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 45, 25, 30),
                child: OverflowBar(
                  alignment: MainAxisAlignment.start,
                  spacing: 8,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset('assets/images/logo.svg', height: 40),
                    Text(
                      context.l10n.appName,
                      textAlign: TextAlign.center,
                      style: context.myTxtTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            // divider,
            BlocBuilder<AuthStateCubit, AuthState>(
              builder: (context, state) {
                return state.user != null
                    ? ListTile(
                        leading: const Icon(Icons.person_outline),
                        style: ListTileStyle.drawer,
                        title: Text(context.l10n.drawerProfileIBtnLabel),
                        onTap: () =>
                            const UserProfileScreenRoute().push(context),
                      )
                    : ListTile(
                        iconColor: context.colorScheme.primary,
                        textColor: context.colorScheme.primary,
                        style: ListTileStyle.drawer,
                        title: Text(context.l10n.loginBtnLabel),
                        leading: const Icon(Icons.login_rounded),
                        onTap: () {
                          LoginScreenRoute(
                            redirectTo: const UserProfileScreenRoute().location,
                          ).push(context);
                        },
                      );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              style: ListTileStyle.drawer,
              title: Text(context.l10n.drawerAboutTheAppTile),
              onTap: () {},
            ),
            const Spacer(),
            divider,
            SwitchListTile.adaptive(
              dense: true,
              value: context.isDarkMode,
              title: Row(
                children: [
                  const Icon(Icons.dark_mode_outlined),
                  const SizedBox(width: 12),
                  Text(context.l10n.drawerDarkModeSwitchTitle),
                ],
              ),
              onChanged: (darkModeEnabled) {
                darkModeEnabled
                    ? context.read<ThemeCubit>().toggleDarkMode()
                    : context.read<ThemeCubit>().toggleLightMode();
              },
            ),
            const SizedBox(height: 5),
            ListTile(
              dense: true,
              leading: const Icon(Icons.language_outlined),
              title: Text(context.l10n.drawerLanguageBtnLabel),
            ),
            const _LanguageTile(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OverflowBar(
        spacing: 8,
        alignment: MainAxisAlignment.start,
        children: [
          ...AppLocalizations.supportedLocales.map((locale) {
            return ChoiceChip(
              padding: const EdgeInsets.all(3),
              selectedColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: context.isDarkMode ? Colors.white12 : Colors.black12,
                ),
              ),
              labelStyle: TextStyle(color: context.colorScheme.onSurface),
              backgroundColor: Colors.transparent,
              checkmarkColor: context.colorScheme.onSurface,
              label: Text(context.getLocaleFullName(locale)),
              selected: locale == context.locale,
              onSelected: (selected) {
                if (selected) {
                  context.read<LocalizationCubit>().setLocale(locale);
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
