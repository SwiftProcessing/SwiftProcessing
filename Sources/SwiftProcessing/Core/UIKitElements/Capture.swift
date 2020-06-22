import UIKit
import AVFoundation
import Vision

open class Camera: UIKitViewElement {
    
    private var previewView: UIView?
    private(set) var cameraIsReadyToUse = false
    
    var alert: Alert
    
    private let session = AVCaptureSession()
    private weak var previewLayer: AVCaptureVideoPreviewLayer?
    private lazy var sequenceHandler = VNSequenceRequestHandler()
    private lazy var capturePhotoOutput = AVCapturePhotoOutput()
    private var videoConnection: AVCaptureConnection?
    private var cameraDevice: AVCaptureDevice?
    
    
    private lazy var dataOutputQueue = DispatchQueue(label: "FaceDetectionService",
                                                     qos: .userInitiated, attributes: [],
                                                     autoreleaseFrequency: .workItem)
    
    private var captureCompletionBlock: ((UIImage) -> Void)?
    private var preparingCompletionHandler: ((Bool) -> Void)?
    private var snapshotImageOrientation = UIImage.Orientation.upMirrored
    
    private var photo:Image?
    
    var AVCapturePositions = ["front" : AVCaptureDevice.Position.front,
                              "back" : AVCaptureDevice.Position.back]
    
    var AVCaptureQuality = ["high" : AVCaptureSession.Preset.high,
                            "medium" : AVCaptureSession.Preset.medium,
                            "low" : AVCaptureSession.Preset.low,
                            "vga" : AVCaptureSession.Preset.vga640x480,
                            "hd" : AVCaptureSession.Preset.hd1280x720,
                            "qhd" : AVCaptureSession.Preset.hd1920x1080]
    
    var orientation = [UIInterfaceOrientation.landscapeLeft : AVCaptureVideoOrientation.landscapeLeft,
                       UIInterfaceOrientation.landscapeRight : AVCaptureVideoOrientation.landscapeRight,
                       UIInterfaceOrientation.portrait : AVCaptureVideoOrientation.portrait,
                       UIInterfaceOrientation.portraitUpsideDown : AVCaptureVideoOrientation.portraitUpsideDown]
    
    var orientationWords = ["up" : AVCaptureVideoOrientation.portrait,
                            "upsidedown" : AVCaptureVideoOrientation.portraitUpsideDown,
                            "left" : AVCaptureVideoOrientation.landscapeLeft,
                            "right" : AVCaptureVideoOrientation.landscapeRight]
    
    init(_ view: Sketch) {
        self.previewView = UIView()
        self.alert = Alert("default", "default")
        super.init(view, self.previewView!)
    }
    
    open func setResolution(_ resolution: String) {
        if let captureQuality = self.AVCaptureQuality[resolution] {
            self.session.sessionPreset = captureQuality
        } else {
            print("Wrong Resolution Key Word")
        }
    }
    
    open func setFrameRate(_ desiredFrameRate: Float64) {
        guard let range = self.cameraDevice!.formats.first!.videoSupportedFrameRateRanges.first,
            range.minFrameRate...range.maxFrameRate ~= (desiredFrameRate)
            else {
                print("Requested FPS is not supported by the device's activeFormat !")
                return
        }
        
        do {
            try self.cameraDevice!.lockForConfiguration()
            self.cameraDevice!.activeVideoMaxFrameDuration = CMTimeMake(value: 1,timescale: Int32(desiredFrameRate))
            self.cameraDevice!.unlockForConfiguration()
        } catch {
            print("Failure when locking Configuration")
        }
    }
    
    private var cameraPosition = AVCaptureDevice.Position.front {
        didSet {
            switch cameraPosition {
            case .front: snapshotImageOrientation = .upMirrored
            case .unspecified, .back: fallthrough
            @unknown default: snapshotImageOrientation = .up
            }
        }
    }
    
    open func getCameraPosition(_ position: String) -> AVCaptureDevice.Position {
        if let AVPosition = self.AVCapturePositions[position] {
            return AVPosition
        } else {
            return AVCaptureDevice.Position.front
        }
    }
    
    func setPhoto(_ width: CGFloat? = nil,_ height: CGFloat? = nil,_ x: CGFloat = 0,_ y: CGFloat = 0,_ finished: @escaping () -> Void) {
        self.capturePhoto { image in
            self.photo =  Image(image)
            if width != nil && height != nil {
                self.photo = self.photo!.get(x,y,width!,height!)
            }
            finished()
        }
        
    }
    
    open func get(_ width: CGFloat? = nil,_ height: CGFloat? = nil,_ x: CGFloat = 0,_ y: CGFloat = 0) -> Image? {
        setPhoto(width,height,x,y) {}
        return self.photo
    }
    
    func prepare(
        cameraPosition: AVCaptureDevice.Position,
        desiredFrameRate: Int? = nil,
        completion: ((Bool) -> Void)?
    ) {
        
        self.preparingCompletionHandler = completion
        self.cameraPosition = cameraPosition
        checkCameraAccess { allowed in
            if allowed { self.setup(desiredFrameRate) }
            completion?(allowed)
            self.preparingCompletionHandler = nil
        }
    }
    
    private func setup(_ desiredFrameRate: Int? = nil) {
        configureCaptureSession(desiredFrameRate)
    }
    
    func start() {
        if cameraIsReadyToUse { session.startRunning() }
    }
    
    func stop() {
        session.stopRunning()
    }
    
}

extension Camera {
    
    private func askUserForCameraPermission(_ completion:  ((Bool) -> Void)?) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (allowedAccess) -> Void in
            DispatchQueue.main.async { completion?(allowedAccess) }
        }
    }
    
    private func checkCameraAccess(_ completion: ((Bool) -> Void)?) {
        askUserForCameraPermission { [weak self] allowed in
            guard let self = self, let completion = completion else { return }
            self.cameraIsReadyToUse = allowed
            if allowed {
                completion(true)
            } else {
                self.showDisabledCameraAlert(completion)
                print("No Access to Camera")
            }
        }
    }
    
    private func configureCaptureSession(_ desiredFrameRate: Int? = nil) {
        guard let previewView = previewView else { return }
        // Define the capture device we want to use
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "No front camera available"])
            let errorAlert = Alert(error)
            errorAlert.show()
            return
        }
        
        // Connect the camera to the capture session input
        do {
            
            try camera.lockForConfiguration()
            defer { camera.unlockForConfiguration() }
            
            if camera.isFocusModeSupported(.continuousAutoFocus) {
                camera.focusMode = .continuousAutoFocus
            }
            
            if camera.isExposureModeSupported(.continuousAutoExposure) {
                camera.exposureMode = .continuousAutoExposure
            }
            if desiredFrameRate != nil {
                
                self.configureFrameRate(camera,desiredFrameRate!)
                
            }
            
            self.cameraDevice = camera
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            session.addInput(cameraInput)
            
        } catch {
            let errorAlert = Alert(error as NSError)
            errorAlert.show()
            return
        }
        
        // Create the video data output
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        // Add the video output to the capture session
        session.addOutput(videoOutput)
        
        let videoConnection = videoOutput.connection(with: .video)
        videoConnection?.videoOrientation = getOrientation((UIApplication.shared.windows.first?.windowScene!.interfaceOrientation)!)
        self.videoConnection = videoConnection
        
        // Configure the preview layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = previewView.bounds
        previewLayer.connection?.videoOrientation = getOrientation((UIApplication.shared.windows.first?.windowScene!.interfaceOrientation)!)
        previewView.layer.insertSublayer(previewLayer, at: 0)
        self.previewLayer = previewLayer
    }
    
    func configureFrameRate(_ camera: AVCaptureDevice,_ desiredFrameRate: Int) {
        guard let range = camera.formats.first!.videoSupportedFrameRateRanges.first,
            range.minFrameRate...range.maxFrameRate ~= Float64(desiredFrameRate)
            else {
                print("Requested FPS is not supported by the device's activeFormat !")
                return
        }
        
        do {
            try camera.lockForConfiguration()
            camera.activeVideoMinFrameDuration = CMTimeMake(value: 1,timescale: Int32(desiredFrameRate))
            camera.activeVideoMaxFrameDuration = CMTimeMake(value: 1,timescale: Int32(desiredFrameRate))
            camera.unlockForConfiguration()
        } catch {
            print("Failure when locking Configuration")
        }
    }
    
    func getOrientation(_ orientation : UIInterfaceOrientation) -> AVCaptureVideoOrientation{
        if let orientationReturnValue = self.orientation[orientation] {
            return orientationReturnValue
        } else {
            return AVCaptureVideoOrientation.portrait
        }
    }
    
    public func rotateCamera(_ orientation: String? = nil) {
        if orientation == nil {
            self.previewLayer?.connection?.videoOrientation = getOrientation((UIApplication.shared.windows.first?.windowScene!.interfaceOrientation)!)
            self.videoConnection?.videoOrientation = getOrientation((UIApplication.shared.windows.first?.windowScene!.interfaceOrientation)!)
        } else {
            if let orientationReturnValue = self.orientationWords[orientation!] {
                self.previewLayer?.connection?.videoOrientation = orientationReturnValue
                self.videoConnection?.videoOrientation = orientationReturnValue
            } else {
                print("Wrong orientation key word")
            }
        }
    }
}

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard   captureCompletionBlock != nil,
            let outputImage = UIImage(sampleBuffer, snapshotImageOrientation) else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let captureCompletionBlock = self.captureCompletionBlock{
                captureCompletionBlock(outputImage)
            }
            self.captureCompletionBlock = nil
        }
    }
}

// Navigation

extension Camera {
    
    private func showDisabledCameraAlert(_ completion: ((Bool) -> Void)?, _ desiredFrameRate: Int? = nil) {
        self.alert = Alert("Enable Camera Access",
                           "Please provide access to your camera",
                           .alert)
        
        self.alert.addAction(title: "Go to Settings", style: .default, handler: { action in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(settingsUrl) else { return }
            UIApplication.shared.open(settingsUrl) { [weak self] _ in
                guard let self = self else { return }
                self.prepare(cameraPosition: self.cameraPosition,
                             desiredFrameRate: desiredFrameRate, completion: self.preparingCompletionHandler
                )
            }
        })
        self.alert.addAction(title: "Cancel", style: .cancel, handler: { _ in completion?(false) })
        self.alert.show()
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func capturePhoto(completion: ((UIImage) -> Void)?) { captureCompletionBlock = completion }
}

extension UIImage {
    
    convenience init?(_ sampleBuffer: CMSampleBuffer,_ orientation: UIImage.Orientation = .upMirrored) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly) }
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        guard let context = CGContext(data: baseAddress, width: width, height: height,
                                      bitsPerComponent: 8, bytesPerRow: bytesPerRow,
                                      space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else { return nil }
        
        guard let cgImage = context.makeImage() else { return nil }
        self.init(cgImage: cgImage, scale: 1, orientation: orientation)
    }
}

extension Sketch{
    
    open func createCamera(_ position: String = "front", _ desiredFrameRate: Int? = nil) -> Camera{
        let b = Camera(self)
        b.prepare(cameraPosition: b.getCameraPosition(position), desiredFrameRate: desiredFrameRate) { success in
            if success { b.start() }
            else {
                print("Could not start Camera because could not prepare camera")
            }
        }
        viewRefs[b.id] = b
        return b
    }
    
    open func createCamera(_ desiredFrameRate: Int? = nil) -> Camera{
        return createCamera("front",desiredFrameRate)
    }
}
