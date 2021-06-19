//
//  SketchContainer.swift
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
        // TODO expose paused boolean to Sketch noLoop
        // TODO expose interval to Sketch frameRate
        TimelineView(.animation(minimumInterval: 1 / 30, paused: false)) { timeline in
            ZStack {
                Canvas(renderer: { context, size in
                    sketch.operations.forEach { $0(context) }
                    sketch.updateContext(
                        context,
                        size,
                        timeline.date.timeIntervalSinceReferenceDate
                    )
                    sketch.display()
                }, symbols: {
                    ForEach(sketch.loadedImages) { image in
                        image.view
                    }
                })
                .drawingGroup()
            }
            .overlay(
                TouchListener { touches in
                    sketch.updateTouches(touches: touches)
                }
            )
        }
       
        
    }
}

@available(iOS 15.0, *)
struct SketchContainer_Previews: PreviewProvider {
    static var previews: some View {
        SketchContainer(sketch: CirclePortalExample())
    }
}
