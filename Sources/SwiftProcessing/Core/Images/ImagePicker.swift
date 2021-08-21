/*
 * SwiftProcessing: Image Picker
 *
 * Adapted from https://theswiftdev.com/picking-images-with-uiimagepickercontroller-in-swift-5/
 *
 * */

import UIKit

public extension Sketch {
    
    class ImagePicker: NSObject {
        
        private let pickerController: UIImagePickerController
        private weak var presentationController: UIViewController?
        
        private var sketch: Sketch!
        open var pickedAction: (Image) -> Void = {image in }
        
        
        public init(_ sketch: Sketch, _ presentationController: UIViewController) {
            self.pickerController = UIImagePickerController()
            self.sketch = sketch
            
            super.init()
            
            self.presentationController = presentationController
            
            self.pickerController.delegate = self
            
            self.pickerController.mediaTypes = ["public.image"]
        }
        
        // TO FUTURE CONTRIBUTORS: Add example use case here for docs.
        
        /// Shows an image picker.
        /// ```
        /// //
        /// ```
        /// - Parameters:
        ///      - type: Image Pcker type. Options are `.camera`, `.photo_library` and `.camera_roll`
        ///      - picked: A completion handler telling SwiftProcessing what to do with the image once it's selected.
        
        public func show(_ type: ImagePickerType = .camera_roll, _ picked: @escaping (Image) -> Void) {
            var pickType: UIImagePickerController.SourceType = .photoLibrary
            switch type{
            case ImagePickerType.camera: pickType = .camera
            case ImagePickerType.camera_roll: pickType = .savedPhotosAlbum
            case ImagePickerType.photo_library: pickType = .photoLibrary
            }
            
            guard UIImagePickerController.isSourceTypeAvailable(pickType) else {
                return
            }
            
            pickedAction = picked
            
            self.pickerController.sourceType = pickType
            self.presentationController?.present(self.pickerController, animated: true)
        }
        
        private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
            controller.dismiss(animated: true, completion: nil)
            if let i = image {
                UIGraphicsPushContext(sketch.context!)
                sketch.push()
                sketch.scale(UIScreen.main.scale, UIScreen.main.scale)
                pickedAction(Image(i))
                sketch.pop()
                UIGraphicsPopContext()
            }
        }
    }
}

extension Sketch.ImagePicker: UIImagePickerControllerDelegate {

    // Image picker overrides.
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension Sketch.ImagePicker: UINavigationControllerDelegate {
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
extension Sketch{
    
    /// Creates an image picker object.
    /// ```
    /// // Creates a new image picker object and stores it in picker
    /// let picker = createImagePicker()
    /// ```
    
    open func createImagePicker() -> ImagePicker{
        return ImagePicker(self, self.parentViewController!)
    }
}

