import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../core/model/file_viewer_arguments.dart';

class FileViewerScreen extends StatelessWidget {
  const FileViewerScreen({
    super.key,
    required this.args,

  });

final FileViewerArguments args;
  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        title: Text(
          args.fileName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () => launchUrl(
              Uri.parse(args.fileUrl),
              mode: LaunchMode.externalApplication,
            ),
          ),
        ],
      ),
      body: args.isPdf
          ? SfPdfViewer.network(args.fileUrl)
          :args. isImage
          ? InteractiveViewer(
        child: Center(child: Image.network(args.fileUrl)),
      )
          : Center(
        child: ElevatedButton(
          onPressed: () => launchUrl(
            Uri.parse(args.fileUrl),
            mode: LaunchMode.externalApplication,
          ),
          child:  Text('Open file'),
        ),
      ),
    );
  }
}