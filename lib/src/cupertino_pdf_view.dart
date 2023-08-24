import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class CupertinoPdfView extends StatelessWidget {
  final String? asset;
  final File? file;
  final Uri? uri;

  const CupertinoPdfView.asset(this.asset, {super.key})
      : file = null,
        uri = null;

  const CupertinoPdfView.file(this.file, {super.key})
      : asset = null,
        uri = null;

  const CupertinoPdfView.network(this.uri, {super.key})
      : asset = null,
        file = null;

  @override
  Widget build(BuildContext context) {
    const String viewType = 'PDFView';
    final Map<String, dynamic> creationParams = <String, dynamic>{
      if (asset != null) 'asset': asset,
      if (file != null) 'path': file?.path,
      if (uri != null) 'uri': uri?.toString(),
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        return Text(
            '$defaultTargetPlatform is not yet supported by the flutter_pdf_kit plugin');
    }
  }
}
