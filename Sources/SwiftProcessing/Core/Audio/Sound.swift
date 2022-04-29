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

/*
 
 NOTE FOR FUTURE CONTRIBUTORS
 
 The Sound library API for Processing can be found here:
 https://processing.org/reference/libraries/sound/index.html
 
 Future contributors should aim for parity with the Processing API.
 
 Currently missing calls for SoundFile from the Processing API include:

 add() - Offset the output of the player by the given value.
 amp() - Changes the amplitude/volume of the player.
 channels() - Returns the number of channels of the soundfile as an int (1 for mono, 2 for stereo).
 cue() - Cues the playhead to a fixed position in the soundfile.
 duration() - Returns the duration of the soundfile in seconds.
 frames() - Returns the number of frames of this soundfile.
 isPlaying() - Check whether this soundfile is currently playing.
 jump() - Jump to a specific position in the soundfile while continuing to play (or starting to play if it wasn't playing already).
 pan() - Move the sound in a stereo panorama.
 pause() - Stop the playback of the file, but cue it to the current position.
 rate() - Set the playback rate of the soundfile.
 removeFromCache() - Remove this SoundFile's decoded audio sample from the cache, allowing it to be garbage collected once there are no more references to this SoundFile.
 set() - Set multiple playback parameters of the soundfile at once.
 */

