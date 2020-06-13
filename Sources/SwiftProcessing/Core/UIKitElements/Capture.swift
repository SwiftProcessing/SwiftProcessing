import Foundation
import UIKit
import AVFoundation
open class Capture: UIKitViewElement, AVCapturePhotoCaptureDelegate{
    
    open var captureSession: AVCaptureSession!
    open var stillImageOutput: AVCapturePhotoOutput!
    open var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var images = [UIImage]()
    var img: UIImage!
    open var previewView: UIView!
    
    init(_ view: Sketch, _ position: String) {
        self.previewView = UIView()
        
        self.captureSession = AVCaptureSession()
        self.captureSession.sessionPreset = .medium
        
        super.init(view, previewView)
        guard let camera = getCaptureDevice(position: position)
            else {
                print("Unable to access camera")
                return
        }
        
        do {
            
            let input = try AVCaptureDeviceInput(device: camera)
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer.videoGravity = .resizeAspect
                videoPreviewLayer.connection?.videoOrientation = .portrait
                self.previewView.layer.addSublayer(videoPreviewLayer)
                DispatchQueue.global(qos: .userInitiated).async {
                    self.captureSession.startRunning()
                    DispatchQueue.main.async {
                        self.videoPreviewLayer.frame = self.previewView.bounds
                    }
                }
            }
        }
        catch let error {
            print("Error unable to initialize back camera: (error.localizedDescription)")
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: {timer in
            let settings = AVCapturePhotoSettings()
            let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
            let previewFormat = [
                kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                kCVPixelBufferWidthKey as String: 160,
                kCVPixelBufferHeightKey as String: 160
            ]
            settings.previewPhotoFormat = previewFormat
            self.stillImageOutput.capturePhoto(with: settings, delegate: self)
        })
        
        
        
    }
    
    func getCaptureDevice(position:String) -> AVCaptureDevice?{
        if position == "front" {
            if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .front) {
                return device
            } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                return device
            } else {
                return AVCaptureDevice.default(for: AVMediaType.video)
            }
        } else if position == "back" {
            if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
                return device
            } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                return device
            } else {
                return AVCaptureDevice.default(for: AVMediaType.video)
            }
        } else {
            return AVCaptureDevice.default(for: AVMediaType.video)
        }
    }
    
    public func capturePhoto() -> Image? {
        if self.img != nil {
            return Image(self.img)
        } else {
            return nil
        }
        
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let error = error {
            print("error occured : \(error.localizedDescription)")
        }
        
        if let dataImage = photo.fileDataRepresentation() {
            print(UIImage(data: dataImage)?.size as Any)
            
            let dataProvider = CGDataProvider(data: dataImage as CFData)
            let cgImageRef: CGImage! = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
            let image = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImage.Orientation.right)
            self.img = image
            self.images.append(image)
                        
        } else {
            print("some error here")
        }
    }
    
    
}


extension Sketch{
    open func createCapture(position: String) -> Capture{
        let b = Capture(self, position)
        viewRefs[b.id] = b
        return b
    }
}
