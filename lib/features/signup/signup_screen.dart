import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:healing_guide_flutter/features/auth/repositories.dart';
import 'package:healing_guide_flutter/features/signup/signup_request.dart';
import 'package:healing_guide_flutter/features/user/models/role.dart';
import 'package:healing_guide_flutter/routes/routes.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_text_field.dart';
import 'package:healing_guide_flutter/widgets/dialogs/error_dialog.dart';
import 'package:healing_guide_flutter/widgets/form/password_text_field.dart';
import 'package:healing_guide_flutter/widgets/form/phone_text_field.dart';
import 'package:healing_guide_flutter/widgets/loading_barrier.dart';

import 'cubit/signup_cubit.dart';
part 'signup_form_fields.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({required this.request, super.key});
  final SignupRequest request;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        authRepository: context.read<AuthRepository>(),
        request: request,
      ),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          switch (state) {
            case SignupSuccessState():
              context.pushReplacement(request.redirectTo);
              break;
            case SignupFailureState state:
              showErrorDialog(
                context,
                title: context.l10n.signupFailureDialogTitle,
                errMessage: state.appException.getMessage(context),
              );
              break;
            default:
              break;
          }
        },
        buildWhen: (previous, current) => previous.isBusy != current.isBusy,
        builder: (context, state) {
          final isBusyOrSuccess = state.isBusy || state is SignupSuccessState;
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  const Padding(
                      padding: EdgeInsets.all(12), child: SignupForm()),
                  if (isBusyOrSuccess)
                    LoadingBarrier(text: context.l10n.signupInProgress),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formHelper = context.read<SignupCubit>().formHelper;
    const formGap = Padding(padding: EdgeInsets.all(10));
    return Form(
      key: formHelper.formKey,
      child: Center(
        child: Container(
          constraints: BoxConstraints.tight(
            Size.fromWidth(min(420, context.screenWidth * .9)),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/logo.svg'),
                formGap,
                Text(
                  context.l10n.appGreeting,
                  style: context.myTxtTheme.titleMedium,
                ),
                formGap,
                Text(
                  _getSubtitle(context),
                  style: context.myTxtTheme.bodyMedium
                      .copyWith(color: context.colorScheme.primary),
                ),
                ...[
                  const SizedBox(height: 48),
                  const _FullNameTextField(),
                  formGap,
                  PhoneTextField(
                    controller: formHelper.phoneNoController,
                    validator: formHelper.phoneNoValidator,
                  ),
                  formGap,
                  const _EmailTextField(),
                  formGap,
                  PasswordTextField(formHelper: formHelper),
                  formGap,
                  const _PasswordConfirmationTextField(),
                  formGap,
                  const _GenderInput(),
                  const SizedBox(height: 48),
                  const _SignupButton(),
                  const SizedBox(height: 48),
                  const _HaveAnExistingAccountSection(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getSubtitle(BuildContext context) {
    final role = context.read<SignupCubit>().request.signupAs;
    return switch (role) {
      Role.patient => context.l10n.signupAsPatientScreenTitle,
      Role.physician => context.l10n.signupAsDoctorScreenTitle,
      Role.guest => throw UnimplementedError(),
    };
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton();
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      key: const Key('signup_raisedButton'),
      onPressed: () {
        FocusScope.of(context).unfocus();
        context.read<SignupCubit>().onSignupRequested();
      },
      style: const ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
      ),
      child: Text(context.l10n.signupBtnLabel),
    );
  }
}

class _HaveAnExistingAccountSection extends StatelessWidget {
  const _HaveAnExistingAccountSection();

  @override
  Widget build(BuildContext context) {
    final redirectTo = context.read<SignupCubit>().request.redirectTo;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.l10n.alreadyHaveAnAccountQuestion),
        TextButton(
          onPressed: () =>
              LoginScreenRoute(redirectTo: redirectTo).pushReplacement(context),
          child: Text(context.l10n.loginBtnLabel),
        ),
      ],
    );
  }
}
