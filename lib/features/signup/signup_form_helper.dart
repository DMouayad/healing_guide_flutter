import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/src/validators.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class SignupFormHelper extends BaseFormHelper {
  static final _translator = {
    '#': RegExp(r'[0-9]{0,3}'),
  };
  static const kPhoneNumberMask = '0 9## ### ###';

  SignupFormHelper()
      : phoneNoController = MaskedTextController(
            mask: kPhoneNumberMask, translator: _translator),
        emailController = TextEditingController(),
        fullNameController = TextEditingController(),
        passwordConfirmationController = TextEditingController(),
        super();

  final TextEditingController phoneNoController;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordConfirmationController;
  bool isMale = true;

  String get phoneNoValue => phoneNoController.text;
  String get fullNameValue => fullNameController.text;
  String get emailValue => emailController.text;

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

  String? emailValidator(String? value, BuildContext context) {
    if (value?.isEmpty ?? true) {
      return context.l10n.emailIsRequired;
    } else {
      if (!isValidEmail(value)) {
        return context.l10n.emailIsInvalid;
      }
    }
    return null;
  }

  String? fullNameValidator(String? value, BuildContext context) {
    if (value?.isEmpty ?? true) {
      return context.l10n.usernameIsRequired;
    }
    return null;
  }

  String? passwordConfirmationValidator(String? value, BuildContext context) {
    if (value?.isEmpty ?? true) {
      return context.l10n.passwordConfirmationIsRequired;
    } else if (value != passwordValue) {
      return context.l10n.passwordConfirmationMismatch;
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    phoneNoController.dispose();
    fullNameController.dispose();
    passwordConfirmationController.dispose();
    emailController.dispose();
  }
}
