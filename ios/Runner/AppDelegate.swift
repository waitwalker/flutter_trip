import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    GeneratedPluginRegistrant.register(with: self)
    
    // 注册自定义plugin
    ASRPlugin.register(with: self.registrar(forPlugin: "ASRPlugin"))
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
