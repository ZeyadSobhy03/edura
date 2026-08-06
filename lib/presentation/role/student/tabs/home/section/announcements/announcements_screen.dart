import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/model/announcement_model.dart';
import 'section/announcement_card.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  List<AnnouncementModel> get _sortedAnnouncements {
    final list = List<AnnouncementModel>.from(DummyAnnouncementData.all);
    list.sort((a, b) {
      if (a.isPinned != b.isPinned) {
        return a.isPinned ? -1 : 1;
      }
      return b.date.compareTo(a.date);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final announcements = _sortedAnnouncements;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        centerTitle: true,
        title: CustomText(
          text: l10.announcements,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: announcements.isEmpty
            ? Center(
                child: CustomText(
                  text: l10.noAnnouncements,
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 14,
                  ),
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  itemCount: announcements.length,
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    return AnnouncementCard(announcement: announcements[index]);
                  },
                ),
              ),
      ),
    );
  }
}
