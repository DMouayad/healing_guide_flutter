import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_scaffold.dart';
import 'package:healing_guide_flutter/widgets/dialogs/error_dialog.dart';

import 'cubit/user_profile_cubit.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 10);
    const divider = Divider(color: AppTheme.dividerColor);
    return BlocProvider(
      create: (context) => UserProfileCubit(context.read()),
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is LogoutFailureState) {
            showErrorDialog(
              context,
              title: context.l10n.logoutFailureDialogTitle,
              errMessage: state.appException.getMessage(context),
            );
          }
        },
        builder: (context, state) {
          return CustomScaffold(
            showLoadingBarrier: state.isBusy,
            title: context.l10n.userProfileScreenTitle,
            bodyPadding: const EdgeInsets.all(25),
            body: Column(
              children: [
                _CustomListTile(
                  onTap: () {},
                  title: context.l10n.publicProfileSettingsTileLabel,
                  icon: Icons.person_outline_outlined,
                ),
                gap,
                ListTile(
                  dense: true,
                  title: Text(context.l10n.accountSettingsTileLabel),
                ),
                gap,
                _CustomListTile(
                  title: context.l10n.changePasswordBtnLabel,
                  icon: Icons.lock_outline_rounded,
                  onTap: context
                      .read<UserProfileCubit>()
                      .onChangePasswordRequested,
                ),
                gap,
                _CustomListTile(
                  title: context.l10n.logoutBtnLabel,
                  icon: Icons.logout,
                  onTap: context.read<UserProfileCubit>().onLogoutRequested,
                ),
                gap,
                gap,
                _CustomListTile(
                  title: context.l10n.deleteAccountBtnLabel,
                  icon: Icons.delete_forever,
                  onTap:
                      context.read<UserProfileCubit>().onDeleteAccountRequested,
                  textColor: AppTheme.redColor,
                  iconColor: AppTheme.redColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      textColor: textColor,
      iconColor: iconColor ?? context.colorScheme.primary,
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(
        Icons.chevron_right,
        color: iconColor ?? context.colorScheme.primary,
      ),
      tileColor: context.colorScheme.inversePrimary,
    );
  }
}
