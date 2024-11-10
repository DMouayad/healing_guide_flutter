import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:healing_guide_flutter/features/signup/signup_form_helper.dart';
import 'package:healing_guide_flutter/features/user/models/role.dart';
import 'package:healing_guide_flutter/routes/routes.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_text_field.dart';
import 'package:healing_guide_flutter/widgets/dialogs/error_dialog.dart';
import 'package:healing_guide_flutter/widgets/form/email_text_field.dart';
import 'package:healing_guide_flutter/widgets/form/password_text_field.dart';
import 'package:healing_guide_flutter/widgets/form/phone_text_field.dart';
import 'package:healing_guide_flutter/widgets/custom_scaffold.dart';

import 'cubit/signup_cubit.dart';
part 'signup_form_fields.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({required this.signupAs, super.key});
  final Role signupAs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(signupAs: signupAs),
      lazy: false,
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          switch (state) {
            case SignupPendingPhoneVerificationState():
              PhoneVerificationScreenRoute(context.read()).push(context);
              break;
            case SignupSuccessState():
              const UserProfileScreenRoute().pushReplacement(context);
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
        buildWhen: (previous, current) =>
            (previous.isBusy != current.isBusy) ||
            current is SignupPendingCompletionState,
        builder: (context, state) {
          return CustomScaffold(
            showBackButton: state is! SignupPendingCompletionState,
            body: state is SignupPendingCompletionState
                ? const _CompleteSignupForm()
                : const SignupForm(),
            showLoadingBarrier: state.isBusy || state is SignupSuccessState,
            loadingBarrierText: context.l10n.signupInProgress,
          );
        },
      ),
    );
  }
}

class _CompleteSignupForm extends StatelessWidget {
  const _CompleteSignupForm();

  @override
  Widget build(BuildContext context) {
    return _BaseForm(
      subtitle: context.l10n.completeSignupFormSubtitle,
      builder: (formHelper, gap) {
        return [
          const SizedBox(height: 48),
          const _FullNameTextField(),
          gap,
          const _GenderInput(),
          const SizedBox(height: 48),
          const _SignupButton(),
        ];
      },
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseForm(
      subtitle: _getSubtitle(context),
      builder: (formHelper, gap) {
        return [
          PhoneTextField(
            controller: formHelper.phoneNoController,
            validator: formHelper.phoneNoValidator,
          ),
          gap,
          EmailTextField(formHelper: formHelper),
          gap,
          PasswordTextField(formHelper: formHelper),
          gap,
          const _PasswordConfirmationTextField(),
          const SizedBox(height: 48),
          const _SignupButton(),
          const SizedBox(height: 48),
          const _HaveAnExistingAccountSection(),
        ];
      },
    );
  }

  String _getSubtitle(BuildContext context) {
    final role = context.read<SignupCubit>().signupAs;
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
    final cubit = context.read<SignupCubit>();
    return FilledButton(
      key: const Key('signup_raisedButton'),
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (cubit.state is SignupPendingCompletionState) {
          context.read<SignupCubit>().onCompleteSignupRequested();
        } else {
          context.read<SignupCubit>().onSignupFormSubmit();
        }
      },
      style: const ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
      ),
      child: Text(
        cubit.state is SignupPendingCompletionState
            ? context.l10n.completeSignupBtnLabel
            : context.l10n.signupBtnLabel,
      ),
    );
  }
}

class _HaveAnExistingAccountSection extends StatelessWidget {
  const _HaveAnExistingAccountSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.l10n.alreadyHaveAnAccountQuestion),
        TextButton(
          onPressed: context.pop,
          child: Text(context.l10n.loginBtnLabel),
        ),
      ],
    );
  }
}

class _BaseForm extends StatelessWidget {
  const _BaseForm({required this.builder, required this.subtitle});
  final List<Widget> Function(SignupFormHelper formHelper, Padding gap) builder;
  final String subtitle;

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
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/logo.svg'),
                formGap,
                Text(
                  getTitle(context),
                  style: context.myTxtTheme.titleMedium,
                ),
                formGap,
                Text(
                  subtitle,
                  style: context.myTxtTheme.bodyMedium
                      .copyWith(color: context.colorScheme.primary),
                ),
                const SizedBox(height: 48),
                ...builder(formHelper, formGap),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getTitle(BuildContext context) {
    return context.read<SignupCubit>().state is SignupPendingCompletionState
        ? context.l10n.completeSignupFormTitle
        : context.l10n.appGreeting;
  }
}
