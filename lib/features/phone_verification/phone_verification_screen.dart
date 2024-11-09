import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:healing_guide_flutter/features/phone_verification/cubit/phone_verification_cubit.dart';
import 'package:healing_guide_flutter/features/signup/cubit/signup_cubit.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_scaffold.dart';
import 'package:healing_guide_flutter/widgets/dialogs/error_dialog.dart';
part './components.dart';

class _NoPopWrapper extends StatelessWidget {
  const _NoPopWrapper({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // the result here is like a confirmation to go back
        if (didPop && (result is bool && result)) {
          context.pop();
        }
      },
      child: child,
    );
  }
}

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({super.key, required this.signupCubit});
  final SignupCubit signupCubit;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PhoneVerificationCubit()),
        BlocProvider.value(value: signupCubit)
      ],
      child: Builder(builder: (context) => const _PhoneVerificationView()),
    );
  }
}

class _PhoneVerificationView extends StatelessWidget {
  const _PhoneVerificationView();

  @override
  Widget build(BuildContext context) {
    const gap24 = SizedBox(height: 24);
    const gap48 = SizedBox(height: 48);
    String getPhoneNumber(BuildContext context) {
      return switch (context.read<SignupCubit>().state) {
        SignupPendingPhoneVerificationState s => s.phoneNumber,
        _ => ''
      };
    }

    return _PhoneVerificationStateListener(
      child: _NoPopWrapper(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: context.screenHeight * .9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  Text(
                    context.l10n.phoneVerificationScreenTitle,
                    style: context.myTxtTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.phoneVerificationScreenSubtitle,
                    style: context.myTxtTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 0,
                    child: Column(
                      children: [
                        Text(
                          context.l10n.phoneVerificationCodeWasSent,
                        ),
                        Text(
                          getPhoneNumber(context),
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        gap24,
                        const _VerificationCodeInputFields(),
                        gap24,
                        const _ResendCodeSection(),
                        const SizedBox(height: 60),
                        const _SubmitButton(),
                        gap48,
                        const _ChangeNumberSection(),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
