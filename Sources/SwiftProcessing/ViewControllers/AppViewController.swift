//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 11/23/19.
//

import Foundation

class AppViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let sketch = self.view as! MySketch
        
        if sketch.isFaceMode && ARFaceTrackingConfiguration.isSupported{
            self.performSegue(withIdentifier: "presentFace", sender: nil)
            
        }
    }
    
    
}
