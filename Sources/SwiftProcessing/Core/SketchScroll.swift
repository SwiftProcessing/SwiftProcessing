import UIKit

public extension Sketch {

    func scroll() {
        self.scrollX()
        self.scrollY()
    }
    
    func scrollX() {
        self.isScrollX = true
    }
    
    func scrollY() {
        self.isScrollY = true
    }
    
    func noScroll() {
        self.noScrollX()
        self.noScrollY()
    }
    
    func noScrollX() {
        self.isScrollX = false
    }
    
    func noScrollY() {
        self.isScrollY = false
    }
    
    func updateDims(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat){
        minX = min([minX, x])
        minY = min([minY, y])
        maxX = max([maxX, x + w])
        maxY = max([maxY, y + h])
    }
    
    func updateScrollView(){
        var size = CGSize()       
        size.width = isScrollX ? maxX: 0
        size.height = isScrollY ? maxY: 0
        self.contentSize = size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isScrollX{
            scrollView.contentOffset.x = 0.0
        }
        if !isScrollY{
            scrollView.contentOffset.y = 0.0
        }
    }
}
