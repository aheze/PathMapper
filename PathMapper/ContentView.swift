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
        Classroom(name: "101", hallwayPoint: CGPoint(x: 90, y: 350)),
        Classroom(name: "102", hallwayPoint: CGPoint(x: 140, y: 350)),
        Classroom(name: "103", hallwayPoint: CGPoint(x: 190, y: 350)),
        Classroom(name: "104", hallwayPoint: CGPoint(x: 290, y: 350)),
        Classroom(name: "105", hallwayPoint: CGPoint(x: 340, y: 350)),
        
        Classroom(name: "201", hallwayPoint: CGPoint(x: 90, y: 190)),
        Classroom(name: "202", hallwayPoint: CGPoint(x: 140, y: 190)),
        Classroom(name: "203", hallwayPoint: CGPoint(x: 190, y: 190)),
        Classroom(name: "204", hallwayPoint: CGPoint(x: 290, y: 190)),
        Classroom(name: "205", hallwayPoint: CGPoint(x: 340, y: 190)),
        
        Classroom(name: "301", hallwayPoint: CGPoint(x: 90, y: 120)),
        Classroom(name: "302", hallwayPoint: CGPoint(x: 140, y: 120)),
        Classroom(name: "303", hallwayPoint: CGPoint(x: 190, y: 120)),
        Classroom(name: "304", hallwayPoint: CGPoint(x: 240, y: 120)),
        Classroom(name: "305", hallwayPoint: CGPoint(x: 290, y: 120)),
        Classroom(name: "306", hallwayPoint: CGPoint(x: 340, y: 120)),
        
        Classroom(name: "401", hallwayPoint: CGPoint(x: 90, y: 50)),
        Classroom(name: "402", hallwayPoint: CGPoint(x: 140, y: 50)),
        Classroom(name: "403", hallwayPoint: CGPoint(x: 190, y: 50)),
        Classroom(name: "404", hallwayPoint: CGPoint(x: 240, y: 50)),
        Classroom(name: "405", hallwayPoint: CGPoint(x: 290, y: 50)),
        Classroom(name: "406", hallwayPoint: CGPoint(x: 340, y: 50)),
        
        MultiEntranceClassroom(
            name: "GYM",
            hallwayPoints: [
                CGPoint(x: 70, y: 190),
                CGPoint(x: 225, y: 240),
                CGPoint(x: 225, y: 300)
            ]
        ),
        
        MultiEntranceClassroom(
            name: "CAF",
            hallwayPoints: [
                CGPoint(x: 225, y: 270),
                CGPoint(x: 270, y: 230)
            ]
        )
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
