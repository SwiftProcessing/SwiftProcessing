//
//  SketchContainer.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import SwiftUI

@available(iOS 15.0, *)
public struct SketchContainer: View {
    @StateObject
    var sketch: SketchUI
    
    public init(sketch: SketchUI) {
        self._sketch = StateObject.init(wrappedValue: sketch)
    }
    
    public var body: some View {
        TimelineView(.animation(minimumInterval: sketch.targetFrameRate, paused: sketch.isPaused)) { timeline in
            Canvas(
                rendersAsynchronously: false,
                   renderer: { context, size in
                sketch.operations.forEach { $0(context) }
                sketch.updateContext(
                    size,
                    timeline.date.timeIntervalSinceReferenceDate
                )
                print(sketch.operations.count, 1 / sketch.deltaTime, sketch.loadedText.count)
                sketch.display()
            }, symbols: {
                ForEach(sketch.loadedImages) { image in
                    image.view
                }
                
                ForEach(sketch.loadedText) { text in
                    AnyView(text.text).tag(text.id)
                }
            })
            .drawingGroup()
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
