/*
 * SwiftProcessing: Microphone Input
 *
 * This is an implementation of microphone input for
 * SwiftProcessing. It allows the user to access a global
 * static singleton
 *
 * */

import UIKit
import AVFoundation

// =======================================================================
// MARK: - CLASS: MIC INPUT
// =======================================================================

open class AudioIn {
    
    /*
     * MARK: - PRIVATE PROPERTIES
     */
    
    // Variables related to the microphone.
    
    private var recorder: AVAudioRecorder!
    private var updated: ((Float) -> Void)?
    private let minDecibels: Float = -80
    
    private let settings: [String:Any] = [
        AVFormatIDKey: kAudioFormatLinearPCM,
        AVSampleRateKey: 44100,
        AVNumberOfChannelsKey: 1,
        AVLinearPCMBitDepthKey: 16,
        AVLinearPCMIsBigEndianKey: false,
        AVLinearPCMIsFloatKey: false
    ]
    
    // Change the multiplier to amplify the effect of sound on your shapes.
    // You can, optionally, create more than one multiplier.
    
    /// A multiplier that enables you to magnify the effect of the microphone input.
    /// Larger = bigger.
    
    public static var multiplier = 1.0
    
    /// The property where the audio level is stored. This includes the effect of any mulitplier.
    
    public var level: Double!
    
    /*
     * MARK: - INIT
     */
    
    /// AudioIn() is a singleton object that is associated with the microphone.
    /// Singleton's ensure that only one object is created. They're often used when
    /// they are associated with a single piece of hardware, like a camera or a
    /// microphone. This is private, but you can refer direclty to
    /// `AudioIn.getLevel()` to access audio input.
    
    private static let shared = AudioIn()
    
    private init() {
        // print("Creating audio in object")
        // Set up the microphone to start listening.
        
        setupAudioSession()
        enableBuiltInMic()
        
        // Create the recorder object.
        do {
            let url = URL(string: NSTemporaryDirectory().appending("tmp.caf"))!
            try recorder = AVAudioRecorder(url: url, settings: settings)
        } catch {
            print("Error occured when attempting to initialize the audio microphone.")
        }
        
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            // print("Permission granted")
        break
        case AVAudioSession.RecordPermission.denied:
            print("Pemission to use the microphone has been denied.")
        case AVAudioSession.RecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                // Handle granted if need be.
            })
            
        @unknown default:
            print("Failed to configure and activate microphone. Make sure you have properly set up your info.plist file in your project to include microphone privacy permissions. If you have not, click the + sign to add a key and look for this key: Privacy - Microphone Usage Description. Then enter a string that explains why you are using the microphone. If that has been done, then make sure you give your program access to your microphone when prompted by iOS or the iOS Simulator.")
        }
    }
    
    // Source: https://developer.apple.com/documentation/avfaudio/avaudiosession/capturing_stereo_audio_from_built-in_microphones
    
    private func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
        } catch {
            print("Failed to configure and activate microphone. Make sure you have properly set up your info.plist file in your project to include microphone privacy permissions. If you have not, click the + sign to add a key and look for this key: Privacy - Microphone Usage Description. Then enter a string that explains why you are using the microphone. If that has been done, then make sure you give your program access to your microphone when prompted by iOS or the iOS Simulator.")
        }
    }
    
    
    private func enableBuiltInMic() {
        // Get the shared audio session.
        let session = AVAudioSession.sharedInstance()
        
        // Find the built-in microphone input.
        guard let availableInputs = session.availableInputs,
              let builtInMicInput = availableInputs.first(where: { $0.portType == .builtInMic }) else {
            print("The device must have a built-in microphone.")
            return
        }
        
        // Make the built-in microphone input the preferred input.
        do {
            try session.setPreferredInput(builtInMicInput)
        } catch {
            print("Unable to set the built-in mic as the preferred input.")
        }
    }
    
    /*
     * MARK: - PUBLIC METHODS
     */
    
    /// Starts the input from the micrphone. This should be run once before input is expected.
    /// `setup()` would be a good place for this function. Do not place it in `draw()`.
    /// ```
    /// // Starts the microphone
    /// func setup() {
    ///   AudioIn.start()
    /// }
    /// ```
    
    public static func start() {
        // Start the microphone.
        print("Starting microphone")
        
        shared.recorder.prepareToRecord()
        shared.recorder.isMeteringEnabled = true
        print(shared.recorder.record())
    }
    
    /// Returns the level of the input coming into the microphone. This can be done on a
    /// frame by frame basis to control shapes or other objects within your sketch.
    /// ```
    /// // Draws a circle using the input level of the mic.
    /// func draw() {
    ///   AudioIn.update()
    ///   circle(width/2, height/2, AudioIn.getLevel())
    /// }
    /// ```

    public static func getLevel() -> Double {
        return shared.level
    }
    
    /*
     * MARK: - PRIVATE CALCULATED PROPERTIES: MIC SIGNAL CONVERSION
     */
    
    // Converting input from microphone to useful, human-readable numbers.
    
    private var micLevel: Float {
        
        let decibels = recorder.averagePower(forChannel: 0)
        
        if decibels < minDecibels {
            return 0
        } else if decibels >= 0 {
            return 1
        }
        
        let minAmp = powf(10, 0.05 * minDecibels)
        let inverseAmpRange = 1 / (1 - minAmp)
        let amp = powf(10, 0.05 * decibels)
        let adjAmp = (amp - minAmp) * inverseAmpRange
        
        return sqrtf(Float(adjAmp))
    }
    
    private var pos: Float {
        // linear level * by max + min scale (20 - 130db)
        return micLevel * 130 + 20
    }
    
    /*
     * MARK: - SAMPLE THE MICROPHONE AND CALL THE CHANGE SHAPE FUNCTION
     */
    
    /// Updates the microphone. This should be done in the `draw()` function.
    /// ```
    /// // Draws a circle using the input level of the mic.
    /// func draw() {
    ///   AudioIn.update()
    ///   circle(width/2, height/2, AudioIn.getLevel())
    /// }
    /// ```
    
    public static func update() {
        self.shared.updateMeter()
    }
    
    @objc private func updateMeter() {
        recorder.updateMeters()
        updated?(pos)
        print(pos)
        level = Double(self.pos)/2.0*AudioIn.multiplier
    }
    
}
