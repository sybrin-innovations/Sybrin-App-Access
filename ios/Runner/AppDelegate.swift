import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    
    
    
    // Flutter Controller and Method Channel
    let flutterController: FlutterViewController = window?.rootViewController as! FlutterViewController
    let accessChannel = FlutterMethodChannel(name: "com.sybrin.access", binaryMessenger: flutterController.binaryMessenger)
    
    // Creating the intermediary ViewController
    let interViewController: IntermediaryViewController = IntermediaryViewController()
    interViewController.modalPresentationStyle = .overFullScreen
    
    // Launching the inter view controller on the main thread
    DispatchQueue.main.async {
        // Getting information from flutter here
        accessChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            NSLog("setMethodCallHandler called")
            
            interViewController.flutterResult = result
            
            // Presenting InterViewController
            if interViewController.isViewLoaded && interViewController.view.window != nil {
                
            } else {
                flutterController.show(interViewController, sender: nil)
            }
            
            // Checking to see if it's the correct method call
            switch call.method {
            case "scanQRCode":
                interViewController.scanQRCode()
                break
            default:
                return result(FlutterMethodNotImplemented)
            }
        })
    }
    
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
