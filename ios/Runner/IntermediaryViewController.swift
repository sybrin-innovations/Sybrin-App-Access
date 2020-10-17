//
//  IntermediaryViewController.swift
//  Runner
//
//  Created by Default on 2020/10/16.
//

import UIKit
import Sybrin_iOS_Common
import MLKit

public final class IntermediaryViewController: UIViewController {
    
    // MARK: Private Properties
    // Camera
    private final var CameraHandlerObj: CameraHandler!
    private final var CameraView: UIView!
    
    // Barcode
    private final var BarcodeScannerOptionsObj: BarcodeScannerOptions?
    private final var BarcodeScannerObj: BarcodeScanner?
    private final var BarcodeFormat: BarcodeFormat = .qrCode
    private final var ExpectedBarcodeURL = "https://forms.office.com/Pages/ResponsePage.aspx?id=8vFhHUs3SEqKA0b8mpB5EcpgdSIzeRxMvGXEf-028bFURDAyN0JVMFFHVUFSWVk0WERIWlRXRVRRQy4u&qrcode=true"
    
    // Fonts
    private final let BigFont = CTFontCreateWithName("Roboto Black" as CFString, 17, nil)
    private final let SmallFont = CTFontCreateWithName("Roboto Light" as CFString, 10, nil)
    
    // MARK: Public Properties
    public final var flutterResult: FlutterResult!
    
    
    // MARK: UIViewController Override Methods
    public final override func viewDidLoad() {
        super.viewDidLoad()
        
        CameraView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        CameraView.backgroundColor = .red
        
        self.view.addSubview(CameraView)
        
        CameraHandlerObj = CameraHandler(CameraView)
        CameraHandlerObj.outputType = .CMSampleBuffer
        CameraHandlerObj.delegate = self
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.AddBrandingLabels()
        }
    }
    
    public final override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            CommonUI.addFlashLightButton(to: self)
            self.ConfigureQRCodeOverlay(self.CameraView)
        }
    }
    
    public final override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public final override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    public final override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Private Methods
    private final func AddBrandingLabels() {
        // Label
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "INNOVATIONS LAB"
        label.font = BigFont
        self.view.addSubview(label)
        
        // Sub Label
        let subLabel = UILabel()
        subLabel.textColor = .white
        subLabel.textAlignment = .center
        subLabel.text = "A DIVISION OF SYBRIN"
        subLabel.font = SmallFont//UIFont(name: "Roboto Light", size: 10)
        self.view.addSubview(subLabel)
        
        // Constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: label.bottomAnchor)
        ]
        let subLabelConstraints = [
            subLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(subLabelConstraints)
    }
    
    private final func ConfigureQRCodeOverlay(_ view: UIView) {
        CommonOverlaysAndCutOuts.userView = view
        
        let cPreviewWidth = view.frame.width
        let cPreviewHeight = view.frame.height
        
        let overlayWidth = (cPreviewWidth * 0.9)
        let overlayHeight = overlayWidth
        
        let overlayY = ((cPreviewHeight / 2) - (overlayHeight / 2))
        let overlayX = ((cPreviewWidth / 2) - (overlayWidth / 2))
        
        let olRect: CGRect = CGRect(x: overlayX, y: overlayY, width: overlayWidth , height: overlayHeight)
        let olUIView: UIView = UIView(frame: olRect)
        olUIView.tag = 100
        
        // Adding the overlay to the camera preview layer
        view.addSubview(olUIView)
        
        // Setting point values
        CommonOverlaysAndCutOuts.topLeftPoint = CGPoint(x: CGFloat(overlayX), y: CGFloat(overlayY))
        CommonOverlaysAndCutOuts.bottomLeftPoint = CGPoint(x: CGFloat(overlayX), y: CGFloat(overlayY + (overlayHeight)))
        
        // Add Overlay
        CommonOverlaysAndCutOuts.addOverlay(withColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        
        // Adding Background cut out
        CommonOverlaysAndCutOuts.addRectCutouts(olUIView)
        
        // Adding Borders
        let enableScanningBar = true
        let enableScanningBorder = true
        let enableScanningParticles = true
        let overlayElementColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let scaninngBarColor = UIColor(red: 0, green: (120 / 255), blue: (200 / 255), alpha: 1)
        
        if enableScanningBar || enableScanningBorder || enableScanningParticles {
            CommonOverlaysAndCutOuts.addCaptureBorders(to: olUIView, borderColor: overlayElementColor, scanningBarColor: scaninngBarColor, enableScanningBar: enableScanningBar, enableScanningBorder: enableScanningBorder, enableScanningParticles: enableScanningParticles)
        }
        
        // Adding Labels
        CommonOverlaysAndCutOuts.updateLabelText(to: "Scan the QR Code", textColor: overlayElementColor)
    }
    
    private final func RemoveSybrinViewController() {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            
            self.removeFromParent()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private final func InitializeBarcodeScanning() {
        let barcodeScannerOptions = BarcodeScannerOptions(formats: BarcodeFormat)
        
        BarcodeScannerOptionsObj = barcodeScannerOptions
        
        BarcodeScannerObj = BarcodeScanner.barcodeScanner(options: barcodeScannerOptions)
    }
    
    private final func BarcodeScanningUsingBufferRealtime(_ buffer: CMSampleBuffer, foundResult: @escaping (_ result: [Barcode]) throws -> Void) {
        if BarcodeScannerObj == nil {
            InitializeBarcodeScanning()
        }
        
        guard let barcodeScanner = BarcodeScannerObj else { return }
        
        let visionImage = VisionImage(buffer: buffer)
        visionImage.orientation = .left
        
        do {
            let result = try barcodeScanner.results(in: visionImage)
            
            if result.count > 0 {
                do {
                    try foundResult(result)
                } catch {
                    print("Error Parsing Barcode: \(error.localizedDescription)")
                    return
                }
            }
        } catch {
            "Realtime Barcode Scanning failed: \(error.localizedDescription)".log(.Error, fromClass: String(describing: self))
            return
        }
    }
    
    private final func ReturnWithJSONResult(result: String) {
        // Checking to see if we have the flutter result to return the data back to flutter
        guard let flutterResult = self.flutterResult else {
            return
        }

        // returning the data back to flutter
        flutterResult(result)

        // Dismissing this screen
        RemoveSybrinViewController()
    }
    
    // MARK: Public Methods
    public final func scanQRCode() {
        print("Let's scan boiiii")
    }
    
}

extension IntermediaryViewController: CameraDelegate {
    
    public final func processFrameCMSampleBuffer(_ cmbuffer: CMSampleBuffer) {
        BarcodeScanningUsingBufferRealtime(cmbuffer) { [weak self] (result) in
            guard let self = self else { return }
            for barcode in result {
                if let url = barcode.displayValue, url == self.ExpectedBarcodeURL {
                    do {
                        let model = ScanResultModel(success: true, value: url)
                        let jsonData = try JSONEncoder().encode(model)
                        if let jsonString = String(data: jsonData, encoding: .utf8) {
                            self.ReturnWithJSONResult(result: jsonString)
                        }
                    } catch  {
                        print("Error Parsing Barcode: \(error.localizedDescription)")
                        return
                    }
                }
            }
        }
    }
    
}
