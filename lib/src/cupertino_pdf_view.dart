import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class CupertinoPdfView extends StatelessWidget {
  final String? asset;
  final File? file;
  final Uri? uri;
  final void Function(CupertinoPdfViewController controller)? onReady;

  const CupertinoPdfView.asset(this.asset, {super.key, this.onReady})
      : file = null,
        uri = null;

  const CupertinoPdfView.file(this.file, {super.key, this.onReady})
      : asset = null,
        uri = null;

  const CupertinoPdfView.network(this.uri, {super.key, this.onReady})
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
          onPlatformViewCreated: (int id) {
            onReady?.call(CupertinoPdfViewController._(id));
          },
        );
      default:
        return Text(
            '$defaultTargetPlatform is not yet supported by the flutter_pdf_kit plugin');
    }
  }
}

class CupertinoPdfViewController {
  final MethodChannel _channel;

  CupertinoPdfViewController._(int id)
      : _channel = MethodChannel('PDFViewController__$id');

  Future<void> goToPage(int i) async {
    await _channel.invokeMethod('goToPage', i);
  }

  Future<void> goToPreviousPage() async {
    await _channel.invokeMethod('goToPreviousPage');
  }

  Future<void> goToNextPage() async {
    await _channel.invokeMethod('goToNextPage');
  }

  Future<void> dispose() async {
    await _channel.invokeMethod('dispose');
  }
}
