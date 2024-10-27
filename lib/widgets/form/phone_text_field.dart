import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_text_field.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField(
      {super.key, required this.controller, required this.validator});
  final TextEditingController controller;
  final String? Function(String?, BuildContext) validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      key: const Key('loginForm_PhoneNumberInput_textField'),
      controller: controller,
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) => validator(value, context),
      autovalidateMode: AutovalidateMode.onUnfocus,
      hintText: context.l10n.phoneNumberFieldHint,
      labelText: context.l10n.phoneNumberFieldLabel,
      textInputAction: TextInputAction.next,
    );
  }
}
