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
    
    public var multiplier = 1.0
    
    /// The property where the audio level is stored. This includes the effect of any mulitplier.
    
    public var level: Double!
    
    /*
     * MARK: - INIT
     */
    
    /// AudioIn() is a singleton object that is associated with the microphone.
    /// Singleton's ensure that only one object is created. They're often used when
    /// they are associated with a single piece of hardware, like a camera or a
    /// microphone. You can refer direclty to AudioIn().shared to access audio input.
    
    public static let shared = AudioIn()
    
    private init() {
        print("Creating audio in object")
        // Set up the microphone to start listening.
        
        // Original code. Replaced with Apple's suggested workflow.
        
        /*
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        } catch let error as NSError {
            print(error.description)
        }
         */

        setupAudioSession()
        enableBuiltInMic()
        
        do {
            let url = URL(string: NSTemporaryDirectory().appending("tmp.caf"))!
            print("recording to")
            print(url)
            try recorder = AVAudioRecorder(url: url, settings: settings)
        } catch {
            print("error!")
        }
        
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            print("Permission granted")
        case AVAudioSession.RecordPermission.denied:
            print("Pemission denied")
        case AVAudioSession.RecordPermission.undetermined:
            print("Request permission here")
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                // Handle granted
            })
        }
    }
    
    // Source: https://developer.apple.com/documentation/avfaudio/avaudiosession/capturing_stereo_audio_from_built-in_microphones
    
    func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
        } catch {
            fatalError("Failed to configure and activate session.")
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
    /// setup() would be a good place for this function. Do not place it in draw().
    
    public func start() {
        // Start the microphone.
        print("Starting microphone")

        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        print(recorder.record())
    }
    
    /// Returns the level of the input coming into the microphone. This can be done on a
    /// frame by frame basis to control shapes or other objects within your sketch.
    
    // Included for parity with p5.js.
    public func getLevel() -> Double {
        return level
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
        
        return sqrtf(adjAmp)
        
    }
    
    private var pos: Float {
        // linear level * by max + min scale (20 - 130db)
        return micLevel * 130 + 20
    }
    
    /*
     * MARK: - SAMPLE THE MICROPHONE AND CALL THE CHANGE SHAPE FUNCTION
     */
    
    public func update() {
        self.updateMeter()
    }
    
    @objc func updateMeter() {
        recorder.updateMeters()
        updated?(pos)
        print(pos)
        level = Double(self.pos)/2.0*self.multiplier
    }
    
    
    
    
}

// FOR REFERENCE
// Source: https://p5js.org/examples/sound-mic-input.html

/* p5.js example:
 
 let mic;

 function setup() {
   createCanvas(710, 200);

   // Create an Audio input
   mic = new p5.AudioIn();

   // start the Audio Input.
   // By default, it does not .connect() (to the computer speakers)
   mic.start();
 }

 function draw() {
   background(200);

   // Get the overall volume (between 0 and 1.0)
   let vol = mic.getLevel();
   fill(127);
   stroke(0);

   // Draw an ellipse with height based on volume
   let h = map(vol, 0, 1, height, 0);
   ellipse(width / 2, h - 25, 50, 50);
 }
 
 */
