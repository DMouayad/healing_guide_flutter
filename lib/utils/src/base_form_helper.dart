part of '../utils.dart';

abstract class BaseFormHelper {
  BaseFormHelper() {
    formKey = GlobalKey();
    passwordController = TextEditingController();
  }

  late final GlobalKey<FormState> formKey;

  late final TextEditingController passwordController;
  String get passwordValue => passwordController.value.text.trim();
  bool get passwordIsValid => passwordController.text.length >= 8;
  String? passwordValidator(String? password, BuildContext context) {
    if (password?.trim().isEmpty ?? true) {
      return context.l10n.passwordIsRequired;
    } else if (password!.trim().length < 8) {
      return context.l10n.passwordIsShort;
    }
    return null;
  }

  void saveFormState() => formKey.currentState?.save();
  bool validateInput() {
    saveFormState();
    return formKey.currentState?.validate() ?? false;
  }

  @mustCallSuper
  void dispose() {
    passwordController.dispose();
  }
}
