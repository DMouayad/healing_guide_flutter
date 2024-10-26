import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_text_field.dart';
import 'package:healing_guide_flutter/widgets/dialogs/error_dialog.dart';
import 'package:healing_guide_flutter/widgets/loading_barrier.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({required this.onSuccess, super.key});
  final void Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          switch (state) {
            case LoginSuccessState():
              onSuccess();
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
    return Form(
      key: context.read<LoginCubit>().formHelper.formKey,
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
                ...const [
                  SizedBox(height: 48),
                  _PhoneNumberInput(),
                  Padding(padding: EdgeInsets.all(12)),
                  _PasswordInput(),
                  Padding(padding: EdgeInsets.all(12)),
                  _LoginButton(),
                  SizedBox(height: 48),
                  _CreateNewAccountSection(),
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

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput();
  @override
  Widget build(BuildContext context) {
    final formHelper = context.read<LoginCubit>().formHelper;
    return CustomTextField(
      key: const Key('loginForm_PhoneNumberInput_textField'),
      controller: formHelper.phoneNoController,
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) => formHelper.phoneNoValidator(value, context),
      autovalidateMode: AutovalidateMode.onUnfocus,
      hintText: context.l10n.phoneNumberFieldLabel,
      labelText: context.l10n.phoneNumberFieldLabel,
      textInputAction: TextInputAction.next,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();
  @override
  Widget build(BuildContext context) {
    final formHelper = context.read<LoginCubit>().formHelper;
    return CustomTextField(
      key: const Key('loginForm_passwordInput_textField'),
      obscure: true,
      controller: formHelper.passwordController,
      validator: (value) => formHelper.passwordValidator(value, context),
      labelText: context.l10n.passwordFieldLabel,
      autovalidateMode: AutovalidateMode.onUnfocus,
      textInputAction: TextInputAction.done,
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
