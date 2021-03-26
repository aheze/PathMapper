//
//  ContentView.swift
//  PathMapper
//
//  Created by Zheng on 3/26/21.
//

import SwiftUI

struct ContentView: View {
    
    let intersections: [CGPoint] = [
        CGPoint(x: 30, y: 50),
        CGPoint(x: 370, y: 50),
        
        CGPoint(x: 30, y: 120),
        CGPoint(x: 225, y: 120),
        CGPoint(x: 370, y: 120),
        
        CGPoint(x: 30, y: 190),
        CGPoint(x: 225, y: 190),
        CGPoint(x: 370, y: 190),
        
        CGPoint(x: 30, y: 350),
        CGPoint(x: 225, y: 350),
        CGPoint(x: 370, y: 350)
    ]
    
    struct DirectionalHallway {
        var start: CGPoint
        var end: CGPoint
    }
    
    let hallways: [DirectionalHallway] = [
        
        /// Horizontal hallways
        DirectionalHallway(
            start: CGPoint(x: 30, y: 50),
            end: CGPoint(x: 370, y: 50)
        ),
        
        DirectionalHallway(
            start: CGPoint(x: 370, y: 120),
            end: CGPoint(x: 225, y: 120)
        ),
        DirectionalHallway(
            start: CGPoint(x: 225, y: 120),
            end: CGPoint(x: 30, y: 120)
        ),
        
        DirectionalHallway(
            start: CGPoint(x: 30, y: 190),
            end: CGPoint(x: 225, y: 190)
        ),
        DirectionalHallway(
            start: CGPoint(x: 225, y: 190),
            end: CGPoint(x: 370, y: 190)
        ),
        
        DirectionalHallway(
            start: CGPoint(x: 370, y: 350),
            end: CGPoint(x: 225, y: 350)
        ),
        DirectionalHallway(
            start: CGPoint(x: 225, y: 350),
            end: CGPoint(x: 30, y: 350)
        ),
        
        /// Vertical hallways
        DirectionalHallway(
            start: CGPoint(x: 30, y: 120),
            end: CGPoint(x: 30, y: 50)
        ),
        DirectionalHallway(
            start: CGPoint(x: 30, y: 190),
            end: CGPoint(x: 30, y: 120)
        ),
        DirectionalHallway(
            start: CGPoint(x: 30, y: 350),
            end: CGPoint(x: 30, y: 190)
        ),
        
        DirectionalHallway(
            start: CGPoint(x: 225, y: 190),
            end: CGPoint(x: 225, y: 120)
        ),
        DirectionalHallway(
            start: CGPoint(x: 225, y: 350),
            end: CGPoint(x: 225, y: 190)
        ),
        
        DirectionalHallway(
            start: CGPoint(x: 370, y: 50),
            end: CGPoint(x: 370, y: 120)
        ),
        DirectionalHallway(
            start: CGPoint(x: 370, y: 120),
            end: CGPoint(x: 370, y: 190)
        ),
        DirectionalHallway(
            start: CGPoint(x: 370, y: 190),
            end: CGPoint(x: 370, y: 350)
        )
    ]
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
