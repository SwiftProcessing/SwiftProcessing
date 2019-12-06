import UIKit
import SceneKit
import ARKit
import SwiftProcessing

class AppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    override func viewDidAppear(_ animated: Bool) {
        let sketch = self.view as! Sketch

        if #available(iOS 11.0, *) {
            if sketch.isFaceMode && ARFaceTrackingConfiguration.isSupported {
                self.performSegue(withIdentifier: "presentFace", sender: nil)

            }
        } else {
            // Fallback on earlier versions
        }
    }

}
