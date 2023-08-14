import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_pdf_kit_method_channel.dart';

abstract class FlutterPdfKitPlatform extends PlatformInterface {
  /// Constructs a FlutterPdfKitPlatform.
  FlutterPdfKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPdfKitPlatform _instance = MethodChannelFlutterPdfKit();

  /// The default instance of [FlutterPdfKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPdfKit].
  static FlutterPdfKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPdfKitPlatform] when
  /// they register themselves.
  static set instance(FlutterPdfKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
