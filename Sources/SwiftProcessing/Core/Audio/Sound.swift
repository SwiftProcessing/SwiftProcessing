/*
 * SwiftProcessing: Sound Output
 *
 * This is an implementation of sound output for
 * SwiftProcessing. It allows the user to play audio
 * files in their sketches.
 *
 * */

import Foundation
import AVFoundation

extension Sketch {
    
    /// A SwiftProcessing class for playing sound files. Includes methods to `play()`, `loop()`, and `stop()`. Only `.wav` files are currently supported.
    
    public class SoundFile {
        
        var player: AVAudioPlayer?
        var name: String
        var ext: String
        
        ///  Initializes a new SoundFile instance.
        ///  ````
        ///  let mySound = SoundFile("myFileName")
        ///  ````
        /// - parameter name: the file name including the extension.

        public init(_ name: String) {
            self.name = name.fileName()
            self.ext = name.fileExtension()
        }
        
        ///  Plays the sound file a single time.
        ///  ````
        ///  mySound.play()
        ///  ````
        
        public func play() {
            
            // Creates a path to the file.
            guard let path = Bundle.main.path(forResource: name, ofType:ext) else {
                return }
            let url = URL(fileURLWithPath: path)
            
            // Use AVFoundation to play the file.
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        ///  Loops the sound file. This method starts playing as well, so `play()` is unnecessary.
        ///  ````
        ///  mySound.loop()
        ///  ````
        
        public func loop() {
            // Creates a path to the file.
            guard let path = Bundle.main.path(forResource: name, ofType:"wav") else {
                return }
            let url = URL(fileURLWithPath: path)
            
            // Use AVFoundation to play the file.
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.numberOfLoops = -1
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        ///  Stops the sound file from playing or looping.
        ///  ````
        ///  mySound.stop()
        ///  ````
        
        public func stop() {
            player?.stop()
        }
    }
    
}


