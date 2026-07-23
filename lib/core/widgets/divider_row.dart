import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DividerRow extends StatelessWidget {
  const DividerRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10=AppLocalizations.of(context)!;
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: 8.0,
            indent: 8.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(l10.or, style: TextStyle(color: Colors.grey)),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: 8.0,
            indent: 8.0,
          ),
        ),
      ],
    );
  }
}
