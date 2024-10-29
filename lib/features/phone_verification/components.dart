part of 'phone_verification_screen.dart';

class _VerificationCodeInputFields extends StatelessWidget {
  const _VerificationCodeInputFields();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PhoneVerificationCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        4,
        (i) {
          var isLast = i == 3;
          return Expanded(
            flex: 0,
            child: _DigitTextField(
              textInputAction:
                  isLast ? TextInputAction.done : TextInputAction.next,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (isLast) {
                    FocusScope.of(context).unfocus();
                  } else {
                    FocusScope.of(context).nextFocus();
                  }
                }
                cubit.onVerificationCodeDigitChanged(i, value);
              },
            ),
          );
        },
      ),
    );
  }
}

class _DigitTextField extends StatelessWidget {
  const _DigitTextField({
    required this.textInputAction,
    required this.onChanged,
  });
  final TextInputAction textInputAction;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.ltr,
      onChanged: onChanged,
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      style: context.myTxtTheme.titleMedium,
      maxLength: 1,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        counterText: '',
        constraints: BoxConstraints.loose(const Size.square(77)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.lightGreyColor),
        ),
      ),
    );
  }
}

class _ResendCodeSection extends StatelessWidget {
  const _ResendCodeSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PhoneVerificationCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: OverflowBar(
        alignment: MainAxisAlignment.start,
        children: [
          Text(context.l10n.didNotReceiveCode),
          BlocBuilder<PhoneVerificationCubit, PhoneVerificationState>(
            buildWhen: (prev, current) =>
                prev.canRequestNewCode() != current.canRequestNewCode(),
            builder: (context, state) {
              return state.canRequestNewCode()
                  ? TextButton(
                      onPressed: cubit.onNewCodeRequested,
                      child: Text(context.l10n.resendVerificationCodeBtnLabel),
                    )
                  : Text(
                      context.l10n.resendVerificationCodeIn,
                      style: context.myTxtTheme.bodyMedium,
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PhoneVerificationCubit>();
    return BlocBuilder<PhoneVerificationCubit, PhoneVerificationState>(
      buildWhen: (prev, current) =>
          prev.inputIsValid() != current.inputIsValid(),
      builder: (context, state) => FilledButton(
        onPressed: state.inputIsValid() ? cubit.onSubmitCode : null,
        style: const ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
        ),
        child: Text(context.l10n.verifyBtnLabel),
      ),
    );
  }
}

class _ChangeNumberSection extends StatelessWidget {
  const _ChangeNumberSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.l10n.wrongNumberToVerify,
          style: context.myTxtTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop(true);
            } else {
              pLogger.w(
                  '`SignupScreenRoute` is not present in the stack before `PhoneVerificationScreeRoute`');
            }
          },
          child: Text(context.l10n.changeNumberToVerify),
        )
      ],
    );
  }
}

class _PhoneVerificationStateListener extends StatelessWidget {
  const _PhoneVerificationStateListener({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneVerificationCubit, PhoneVerificationState>(
      listener: (context, state) {
        switch (state) {
          case PhoneVerificationSuccessState():
            context.read<SignupCubit>().onSignupRequestedAfterVerification();
            break;
          case PhoneVerificationFailureState errState:
            showErrorDialog(
              context,
              title: context.l10n.phoneVerificationErrorDialogTitle,
              errMessage: errState.appException.getMessage(context),
            );
            break;
          default:
            break;
        }
      },
      builder: (context, state) => CustomScaffold(
        showLoadingBarrier: state is PhoneVerificationInProgressState ||
            state is PhoneVerificationSuccessState,
        bodyPadding: EdgeInsets.zero,
        body: child,
      ),
    );
  }
}
