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
        let offsetX = context == nil ? 0 : max([0, (context?.ctm.tx)! / UIScreen.main.scale - contentOffset.x])
        let offsetY = context == nil ? 0 : max([0, -(context?.ctm.ty)! / UIScreen.main.scale + frame.height - contentOffset.y])
       
        minX = min([minX + offsetX, x + offsetX])
        minY = min([minY, y + offsetY])
        maxX = max([maxX, x + offsetX + w])
        maxY = max([maxY, y + offsetY + h])
    }
    
    func updateScrollView(){
        let maxSubViewX = self.subviews.reduce(0, {(m: CGFloat, child) in max([m, child.frame.maxX])})
        let maxSubViewY = self.subviews.reduce(0, {(m: CGFloat, child) in max([m, child.frame.maxY - (child.superview?.frame.maxY)!])})
        var size = CGSize()       
        size.width = isScrollX ? max([maxX, maxSubViewX]): 0
        size.height = isScrollY ? max([maxY, maxSubViewY]): 0
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        isScrolling = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
           withVelocity velocity: CGPoint,
           targetContentOffset: UnsafeMutablePointer<CGPoint>){
        isScrolling = false
    }
}
