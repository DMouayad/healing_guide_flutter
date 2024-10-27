part of 'signup_screen.dart';

class _FullNameTextField extends StatelessWidget {
  const _FullNameTextField();

  @override
  Widget build(BuildContext context) {
    final formHelper = context.read<SignupCubit>().formHelper;
    return CustomTextField(
      key: const Key('signupForm_FullName_textField'),
      controller: formHelper.fullNameController,
      validator: (value) => formHelper.fullNameValidator(value, context),
      hintText: context.l10n.usernameFieldHint,
      labelText: context.l10n.usernameFieldLabel,
      textInputAction: TextInputAction.next,
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context) {
    final formHelper = context.read<SignupCubit>().formHelper;
    return CustomTextField(
      key: const Key('signupForm_Email_textField'),
      controller: formHelper.emailController,
      validator: (value) => formHelper.emailValidator(value, context),
      hintText: context.l10n.emailFieldHint,
      labelText: context.l10n.emailFieldLabel,
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }
}

class _PasswordConfirmationTextField extends StatelessWidget {
  const _PasswordConfirmationTextField();

  @override
  Widget build(BuildContext context) {
    final formHelper = context.read<SignupCubit>().formHelper;
    return CustomTextField(
      key: const Key('signupForm_PasswordConfirmation_textField'),
      obscure: true,
      controller: formHelper.passwordConfirmationController,
      validator: (value) =>
          formHelper.passwordConfirmationValidator(value, context),
      hintText: context.l10n.passwordConfirmationFieldHint,
      labelText: context.l10n.passwordConfirmationFieldLabel,
      textInputAction: TextInputAction.done,
    );
  }
}

class _GenderInput extends StatefulWidget {
  const _GenderInput();

  @override
  State<_GenderInput> createState() => _GenderInputState();
}

class _GenderInputState extends State<_GenderInput> {
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    final formHelper = context.read<SignupCubit>().formHelper;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.l10n.genderInputTitle),
          ChoiceChip(
            label: Text(context.l10n.maleGender),
            selected: isMale,
            padding: const EdgeInsets.all(13),
            onSelected: (value) {
              setState(() => isMale = value);
              formHelper.isMale = isMale;
            },
          ),
          ChoiceChip(
            label: Text(context.l10n.femaleGender),
            selected: !isMale,
            padding: const EdgeInsets.all(13),
            onSelected: (value) {
              setState(() => isMale = !value);
              formHelper.isMale = isMale;
            },
          ),
        ],
      ),
    );
  }
}
