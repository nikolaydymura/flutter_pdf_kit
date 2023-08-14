import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pdf_kit/flutter_pdf_kit.dart';
import 'package:flutter_pdf_kit/flutter_pdf_kit_platform_interface.dart';
import 'package:flutter_pdf_kit/flutter_pdf_kit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPdfKitPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPdfKitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPdfKitPlatform initialPlatform = FlutterPdfKitPlatform.instance;

  test('$MethodChannelFlutterPdfKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPdfKit>());
  });

  test('getPlatformVersion', () async {
    FlutterPdfKit flutterPdfKitPlugin = FlutterPdfKit();
    MockFlutterPdfKitPlatform fakePlatform = MockFlutterPdfKitPlatform();
    FlutterPdfKitPlatform.instance = fakePlatform;

    expect(await flutterPdfKitPlugin.getPlatformVersion(), '42');
  });
}
