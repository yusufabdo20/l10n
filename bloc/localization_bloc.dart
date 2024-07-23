import 'package:bloc/bloc.dart';
// import 'package:eeh/shared/utility/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_state.dart';

/* 
 MaterialApp(
  localizationsDelegates: [AppLocalizations.delegate],
  supportedLocales: AppLocalizations.supportedLocales.map((locale) => Locale(locale)).toList(),
  home: MyHomePage(),
)
 */
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState(Locale('en'))) {
    on<LocaleEvent>((event, emit) async {
      if (event == LocaleEvent.toggle) {
        final newLocale =
            state.locale.languageCode == 'en' ? Locale('ar') : Locale('en');
        emit(LocaleState(newLocale));
        _saveLocale(newLocale.languageCode);
        getLocale();
        print(getLocale());
      }
    });
    _loadLocale();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString('locale') ?? 'en';
    final initialLocale = localeCode == 'en'
        ? Locale('en')
        : localeCode == 'ar'
            ? Locale('ar')
            : Locale('fr');

    emit(LocaleState(initialLocale)); // Directly emit the initial locale state
  }

  void _saveLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', code);
    print(prefs.get('locale'));
  }

  getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('locale') ??
        supportedLocales[0]; // Use the first supported locale as default
  }
}

enum LocaleEvent { toggle }
