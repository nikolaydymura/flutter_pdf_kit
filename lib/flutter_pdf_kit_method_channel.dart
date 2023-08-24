import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_pdf_kit_platform_interface.dart';

/// An implementation of [FlutterPdfKitPlatform] that uses method channels.
class MethodChannelFlutterPdfKit extends FlutterPdfKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pdf_kit');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
