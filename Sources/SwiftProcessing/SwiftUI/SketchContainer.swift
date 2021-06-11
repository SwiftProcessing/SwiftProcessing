//
//  SwiftUIView.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SketchContainer: View {
    
    var sketch: SketchUI
    
    public init(sketch: SketchUI) {
        self.sketch = sketch
    }
    
    public var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                sketch.updateContext(
                    context,
                    size,
                    timeline.date.timeIntervalSinceReferenceDate
                )
                sketch.display()
            }
        }
        
    }
}

@available(iOS 15.0, *)
struct SketchContainer_Previews: PreviewProvider {
    static var previews: some View {
        SketchContainer(sketch: CirclePortalExample())
    }
}
