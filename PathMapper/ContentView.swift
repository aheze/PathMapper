//
//  ContentView.swift
//  PathMapper
//
//  Created by Zheng on 3/26/21.
//

import SwiftUI

struct ContentView: View {
    
    struct DirectionalHallway {
        var start: CGPoint
        var end: CGPoint
    }
    
    struct Classroom {
        var name: String
        var hallwayPoint: CGPoint
    }
    
    struct MultiEntranceClassroom {
        var name: String
        var hallwayPoints: [CGPoint]
    }
    
    /// hallway intersections
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
    
    let hallways: [DirectionalHallway] = [
        
        /// horizontal hallways
        DirectionalHallway( start: CGPoint(x: 30, y: 50), end: CGPoint(x: 370, y: 50) ),
        
        DirectionalHallway( start: CGPoint(x: 370, y: 120), end: CGPoint(x: 225, y: 120) ),
        DirectionalHallway( start: CGPoint(x: 225, y: 120), end: CGPoint(x: 30, y: 120) ),
        
        DirectionalHallway( start: CGPoint(x: 30, y: 190), end: CGPoint(x: 225, y: 190) ),
        DirectionalHallway( start: CGPoint(x: 225, y: 190), end: CGPoint(x: 370, y: 190) ),
        
        DirectionalHallway( start: CGPoint(x: 370, y: 350), end: CGPoint(x: 225, y: 350) ),
        DirectionalHallway( start: CGPoint(x: 225, y: 350), end: CGPoint(x: 30, y: 350) ),
        
        /// vertical hallways
        DirectionalHallway( start: CGPoint(x: 30, y: 120), end: CGPoint(x: 30, y: 50) ),
        DirectionalHallway( start: CGPoint(x: 30, y: 190), end: CGPoint(x: 30, y: 120) ),
        DirectionalHallway( start: CGPoint(x: 30, y: 350), end: CGPoint(x: 30, y: 190) ),
        
        DirectionalHallway( start: CGPoint(x: 225, y: 190), end: CGPoint(x: 225, y: 120) ),
        DirectionalHallway( start: CGPoint(x: 225, y: 350), end: CGPoint(x: 225, y: 190) ),
        
        DirectionalHallway( start: CGPoint(x: 370, y: 50), end: CGPoint(x: 370, y: 120) ),
        DirectionalHallway( start: CGPoint(x: 370, y: 120), end: CGPoint(x: 370, y: 190) ),
        DirectionalHallway( start: CGPoint(x: 370, y: 190), end: CGPoint(x: 370, y: 350) )
    ]
    
    let buildings: [Any] = [
        Classroom(name: "101", hallwayPoint: CGPoint(x: 40, y: 40))
    ]
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .frame(width: 400, height: 400)
            
            Image("Hallways")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400, height: 400)
            
            
                MapView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
