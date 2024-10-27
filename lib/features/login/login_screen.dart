import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/dialogs/error_dialog.dart';
import 'package:healing_guide_flutter/widgets/form/password_text_field.dart';
import 'package:healing_guide_flutter/widgets/form/phone_text_field.dart';
import 'package:healing_guide_flutter/widgets/loading_barrier.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({required this.redirectTo, super.key});
  final String redirectTo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          switch (state) {
            case LoginSuccessState():
              context.pushReplacement(redirectTo);
              break;
            case LoginFailureState state:
              showErrorDialog(
                context,
                title: context.l10n.loginFailureDialogTitle,
                errMessage: state.appException.getMessage(context),
              );
              break;
            default:
              break;
          }
        },
        buildWhen: (previous, current) => previous.isBusy != current.isBusy,
        builder: (context, state) {
          final isBusyOrSuccess = state.isBusy || state is LoginSuccessState;
          return Scaffold(
            body: Stack(
              children: [
                const Padding(padding: EdgeInsets.all(12), child: LoginForm()),
                if (isBusyOrSuccess)
                  LoadingBarrier(text: context.l10n.loginInProgress),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formHelper = context.read<LoginCubit>().formHelper;
    return Form(
      key: formHelper.formKey,
      child: Center(
        child: Container(
          constraints: BoxConstraints.tight(
            Size.fromWidth(min(420, context.screenWidth * .9)),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/logo.svg'),
                const Padding(padding: EdgeInsets.all(12)),
                Text(
                  context.l10n.appGreeting,
                  style: context.myTxtTheme.titleMedium,
                ),
                const Padding(padding: EdgeInsets.all(12)),
                Text(
                  context.l10n.loginScreenSubtitle,
                  style: context.myTxtTheme.bodyMedium,
                ),
                ...[
                  const SizedBox(height: 48),
                  PhoneTextField(
                    controller: formHelper.phoneNoController,
                    validator: formHelper.phoneNoValidator,
                  ),
                  const Padding(padding: EdgeInsets.all(12)),
                  PasswordTextField(formHelper: formHelper),
                  const Padding(padding: EdgeInsets.all(12)),
                  const _LoginButton(),
                  const SizedBox(height: 48),
                  const _CreateNewAccountSection(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateNewAccountSection extends StatelessWidget {
  const _CreateNewAccountSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.l10n.noAccountQuestion),
        const SizedBox(height: 16),
        Theme(
          data: context.theme.copyWith(
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                context.screenWidth < 400
                    ? context.myTxtTheme.bodySmall
                    : context.myTxtTheme.bodyMedium,
              )),
            ),
          ),
          child: OverflowBar(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(context.l10n.createDoctorAccountBtnLabel),
              ),
              const Text('|'),
              TextButton(
                onPressed: () {},
                child: Text(context.l10n.createPatientAccountBtnLabel),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: () {
        FocusScope.of(context).unfocus();
        context.read<LoginCubit>().onLoginRequested();
      },
      style: const ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
      ),
      child: Text(context.l10n.loginBtnLabel),
    );
  }
}
