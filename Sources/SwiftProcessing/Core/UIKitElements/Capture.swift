//
//  Capture.swift
//
//
//  Created by Juan Lee on 2020-06-05.
//

import Foundation
import UIKit

open class Capture: UIKitViewElement {
    
    open var captureSession: AVCaptureSession!
    open var stillImageOutput: AVCapturePhotoOutput!
    open var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    init(_ view: Sketch) {
        
        let previewView = UIView()
        
        self.captureSession = AVCaptureSession()
        self.captureSession.sessionPreset = .medium
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                
                videoPreviewLayer.videoGravity = .resizeAspect
                videoPreviewLayer.connection?.videoOrientation = .portrait
                previewView.layer.addSublayer(videoPreviewLayer)
                
                DispatchQueue.global(qos: .userInitiated).async {
                    self.captureSession.startRunning()
                    
                    DispatchQueue.main.async {
                        self.videoPreviewLayer.frame = previewView.bounds
                    }
                }
            }
        }
        catch let error {
            print("Error unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        super.init(view, previewView)

    }
    
    open func getPhoto(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation()
            else{
                return
        }
        
        let image = UIImage(data: imageData)
        return image
    }
    
    
    
}


extension Sketch{
    open func createCapture() -> Capture{
        let b = Capture(self)
        viewRefs[b.id] = b
        return b
    }
}
