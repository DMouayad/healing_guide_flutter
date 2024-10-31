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
    const divider = Divider(color: AppTheme.lightGreyColor);
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 45, 25, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SvgPicture.asset('assets/images/logo.svg', height: 65),
                ),
                Text(
                  context.l10n.appName,
                  textAlign: TextAlign.center,
                  style: context.myTxtTheme.titleLarge,
                ),
              ],
            ),
          ),
          divider,
          BlocBuilder<AuthStateCubit, AuthState>(
            builder: (context, state) {
              return state.user != null
                  ? ListTile(
                      minTileHeight: 65,
                      leading: const Icon(Icons.person_outline_rounded),
                      style: ListTileStyle.drawer,
                      title: Text(context.l10n.drawerProfileIBtnLabel),
                      onTap: () {
                        //TODO: UserProfileScreenRoute().push(context);
                      },
                    )
                  : ListTile(
                      title: Text(context.l10n.loginBtnLabel),
                      leading: const Icon(Icons.login_rounded),
                      onTap: () => LoginScreenRoute(
                        //TODO: redirect to UserProfileScreenRoute
                        redirectTo: HomeScreenRoute().location,
                      ).push(context),
                    );
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.settings_applications),
            title: Text(context.l10n.drawerSettingsTileLabel),
          ),
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
          const SizedBox(height: 50),
        ],
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
