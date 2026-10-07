import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../../presentation/role/student/tabs/profile/presentation/view/section/settings/sections/settings_group_card.dart';
import '../../presentation/role/student/tabs/profile/presentation/view/section/settings/widgets/language_picker_sheet.dart';
import '../../presentation/role/student/tabs/profile/presentation/view/section/settings/widgets/settings_tile.dart';
import '../cubit/language_cubit.dart';

class ChangeLanguageCard extends StatefulWidget {
  const ChangeLanguageCard({super.key});

  @override
  State<ChangeLanguageCard> createState() => _ChangeLanguageCardState();
}

class _ChangeLanguageCardState extends State<ChangeLanguageCard> {
  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return SettingsGroupCard(
      children: [
        BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return SettingsTile(
              icon: Icons.language,
              title: l10.language,
              trailingText: locale.languageCode == 'ar'
                  ? 'العربية'
                  : 'English',
              onTap: _showLanguagePicker,
            );
          },
        ),
      ],
    );
  }

  void _showLanguagePicker() {
    final languageCubit = context.read<LanguageCubit>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => LanguagePickerSheet(
        currentLanguageCode: languageCubit.state.languageCode,
        onSelected: (code) {
          languageCubit.setLanguage(Locale(code));
        },
      ),
    );
  }
}
