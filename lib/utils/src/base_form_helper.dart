part of '../utils.dart';

abstract class BaseFormHelper {
  BaseFormHelper() {
    formKey = GlobalKey();
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  late final GlobalKey<FormState> formKey;

  late final TextEditingController emailController;
  String get emailValue => emailController.text;
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

  late final TextEditingController passwordController;
  String get passwordValue => passwordController.value.text.trim();
  bool get passwordIsValid => passwordController.text.length >= 8;
  String? passwordValidator(String? password, BuildContext context) {
    if (password?.trim().isEmpty ?? true) {
      return context.l10n.passwordIsRequired;
    } else if (!_isValidPassword(password!)) {
      return context.l10n.passwordValidationError;
    }
    return null;
  }

  bool _isValidPassword(String value) {
    return RegExp(r'\W+').hasMatch(value) &&
        RegExp(r'[A-Z]+').hasMatch(value) &&
        value.trim().length > 8;
  }

  void saveFormState() => formKey.currentState?.save();
  bool validateInput() {
    saveFormState();
    return formKey.currentState?.validate() ?? false;
  }

  @mustCallSuper
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
  }
}
