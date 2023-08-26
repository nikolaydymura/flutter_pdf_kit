import Flutter
import PDFKit
import UIKit

public class FlutterPdfKitPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let factory = PDFViewFactory(registrar: registrar)

    registrar.register(
                  factory,
                  withId: "PDFView")
  }
}

class PDFViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    private let registrar: FlutterPluginRegistrar

    init(registrar: FlutterPluginRegistrar) {
        self.messenger = registrar.messenger()
        self.registrar = registrar
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        guard let params = args as? [String: Any],
            let path = params.file(registrar: registrar) else {
            fatalError("Path not provided or invalid")
        }
        return PDFViewNative(
            frame: frame,
            viewIdentifier: viewId,
            path: path,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class PDFViewNative : NSObject, FlutterPlatformView {
    private let _view: PDFView
    private var _pdfDocument: PDFDocument?
    private let _channel: FlutterMethodChannel

    init(
            frame: CGRect,
            viewIdentifier viewId: Int64,
            path: URL,
            binaryMessenger messenger: FlutterBinaryMessenger?
        ) {
            _channel = FlutterMethodChannel(name: "PDFViewController__\(viewId)", binaryMessenger: messenger!)
            _pdfDocument = PDFDocument(url: path)
            _view = PDFView(frame: frame)
            _view.autoScales = true
            _view.pageBreakMargins = UIEdgeInsets.init(top: 10, left: 4, bottom: 10, right: 4)
            _view.document = _pdfDocument
            
            super.init()
            
            _channel.setMethodCallHandler(handle(call:result:))
        }

        func view() -> UIView {
            return _view
        }
    
    private func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "goToPage"  {
            guard let pageIndex = call.arguments as? Int else {
                result(FlutterError(code: "flutter_pdf_kit", message: "Invalid page index argument", details: nil))
                return
            }
            goToPage(index: pageIndex)
            result(nil)
        }
        result(FlutterMethodNotImplemented)
    }
    
    func goToPage(index: Int) {
        guard let page = _pdfDocument?.page(at: index) else {
            return
        }
        _view.go(to: page)
    }
}


extension Dictionary where Key == String {
    func file(registrar: FlutterPluginRegistrar) -> URL? {
        if let path = self["path"] as? String {
            return URL(fileURLWithPath: path)
        } else if let path = self["url"] as? String {
            return URL(string: path)
        } else if let asset = self["asset"] as? String {
            let assetKey = registrar.lookupKey(forAsset: asset)
            
            guard let path = Bundle.main.path(forResource: assetKey, ofType: nil) else {
                return nil
            }
            return URL(fileURLWithPath: path)
        }
        return nil
    }
}
