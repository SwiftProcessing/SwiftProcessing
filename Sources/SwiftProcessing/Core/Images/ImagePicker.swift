//
//  ImagePicker.swift
//
//
//  Created by Jonathan Kaufman on 9/6/20.
//  Adapted from https://theswiftdev.com/picking-images-with-uiimagepickercontroller-in-swift-5/

import UIKit

open class ImagePicker: NSObject {
    
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
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    public func show(for type: UIImagePickerController.SourceType, _ picked: @escaping (Image) -> Void) {
        
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return
        }
        
        pickedAction = picked
        
        self.pickerController.sourceType = type
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

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
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
    open func createImagePicker() -> ImagePicker{
        return ImagePicker(self, self.parentViewController!)
    }
}

