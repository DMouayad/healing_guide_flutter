import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

import '../custom_text_field.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, required this.formHelper});
  final BaseFormHelper formHelper;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
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
