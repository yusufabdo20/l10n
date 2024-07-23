import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghada/l10n/app_localizations.dart';
import 'package:ghada/l10n/bloc/localization_bloc.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              BlocProvider.of<LocaleBloc>(context).add(LocaleEvent.toggle);
            },
            child: Text(AppLocalizations.of(context).translate("lang"))),
        const Icon(Icons.language),
      ],
    );
  }
}
