import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_text_field.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.formHelper,
    this.textInputAction = TextInputAction.next,
  });
  final BaseFormHelper formHelper;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      obscure: true,
      controller: formHelper.passwordController,
      validator: (value) => formHelper.passwordValidator(value, context),
      labelText: context.l10n.passwordFieldLabel,
      textInputAction: textInputAction,
    );
  }
}
