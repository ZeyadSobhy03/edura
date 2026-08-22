import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class ChangeVideoCard extends StatefulWidget {
  const ChangeVideoCard({
    super.key,
    required this.videoThumbnailUrl,
    required this.videoUrl,
  });

  final String videoThumbnailUrl;
  final String videoUrl;


  @override
  State<ChangeVideoCard> createState() => _ChangeVideoCardState();
}

class _ChangeVideoCardState extends State<ChangeVideoCard> {
  late String videoUrl;

  @override
  void initState() {
    super.initState();
    videoUrl = widget.videoUrl;
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(33),
            border: Border.all(
              color: ColorManager.black.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          width: double.infinity,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.videoThumbnailUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;

                return Container(
                  color: ColorManager.gray.withValues(alpha: 0.1),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ColorManager.primary.withValues(alpha: 0.5),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: ColorManager.primary.withValues(alpha: 0.08),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.menu_book_outlined,
                    size: 18,
                    color: ColorManager.primary.withValues(alpha: 0.6),
                  ),
                );
              },
            ),
          ),
        ),

        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: _pickVideo,
                icon: const Icon(Icons.camera_alt_outlined, size: 32),
                color: ColorManager.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 8),
            CustomText(
              text: l10.changeVideo,
              style: const TextStyle(
                color: ColorManager.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickVideo() async {
    final result = await FilePicker.pickFiles(type: FileType.video);

    if (result != null && result.files.single.path != null) {
      setState(() {
        videoUrl = result.files.single.path!;
      });

      debugPrint('New Video Path: $videoUrl');
    }
  }
}
