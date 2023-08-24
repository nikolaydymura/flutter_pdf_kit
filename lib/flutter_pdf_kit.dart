import 'package:flutter/cupertino.dart';

import 'flutter_pdf_kit_platform_interface.dart';

export 'src/cupertino_pdf_view.dart';

@visibleForTesting
class FlutterPdfKit {
  Future<String?> getPlatformVersion() {
    return FlutterPdfKitPlatform.instance.getPlatformVersion();
  }
}
