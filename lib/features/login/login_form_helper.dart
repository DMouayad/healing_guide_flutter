import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/src/validators.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class LoginFormHelper extends BaseFormHelper {
  final _translator = {
    '#': RegExp(r'[0-9]{0,3}'),
  };
  static const kPhoneNumberMask = '0 9## ### ###';
  LoginFormHelper() : super() {
    phoneNoController =
        MaskedTextController(mask: kPhoneNumberMask, translator: _translator);
  }

  late final TextEditingController phoneNoController;

  String get phoneNoValue => phoneNoController.text;

  String? phoneNoValidator(String? value, BuildContext context) {
    if (value?.isEmpty ?? true) {
      return context.l10n.phoneNumberIsRequired;
    } else {
      if (!isValidPhoneNo(value)) {
        return context.l10n.phoneNumberIsInvalid;
      }
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    phoneNoController.dispose();
  }
}
