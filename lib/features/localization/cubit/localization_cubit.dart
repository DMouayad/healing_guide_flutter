import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'localization_state.dart';

const kDefaultLocale = Locale('ar');
const _kLangCodeStorageKey = 'langCode';

class LocalizationCubit extends HydratedCubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationState(kDefaultLocale));
  void setLocale(Locale locale) {
    if (state.locale != locale) {
      emit(LocalizationState(locale));
    }
  }

  @override
  LocalizationState? fromJson(Map<String, dynamic> json) {
    if (json case {_kLangCodeStorageKey: String langCode}
        when _langCodeIsSupported(langCode)) {
      return LocalizationState(Locale(langCode));
    }
    return null;
  }

  bool _langCodeIsSupported(String code) {
    return AppLocalizations.supportedLocales
        .any((locale) => locale.languageCode == code);
  }

  @override
  Map<String, dynamic>? toJson(LocalizationState state) {
    return {_kLangCodeStorageKey: state.locale.languageCode};
  }
}
