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
        var entrancePoint: CGPoint
    }
    
    struct LargeBuilding {
        var name: String
        var entrancePoints: [CGPoint]
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
        Classroom(name: "101", entrancePoint: CGPoint(x: 90, y: 350)),
        Classroom(name: "102", entrancePoint: CGPoint(x: 140, y: 350)),
        Classroom(name: "103", entrancePoint: CGPoint(x: 190, y: 350)),
        Classroom(name: "104", entrancePoint: CGPoint(x: 290, y: 350)),
        Classroom(name: "105", entrancePoint: CGPoint(x: 340, y: 350)),
        
        Classroom(name: "201", entrancePoint: CGPoint(x: 90, y: 190)),
        Classroom(name: "202", entrancePoint: CGPoint(x: 140, y: 190)),
        Classroom(name: "203", entrancePoint: CGPoint(x: 190, y: 190)),
        Classroom(name: "204", entrancePoint: CGPoint(x: 290, y: 190)),
        Classroom(name: "205", entrancePoint: CGPoint(x: 340, y: 190)),
        
        Classroom(name: "301", entrancePoint: CGPoint(x: 90, y: 120)),
        Classroom(name: "302", entrancePoint: CGPoint(x: 140, y: 120)),
        Classroom(name: "303", entrancePoint: CGPoint(x: 190, y: 120)),
        Classroom(name: "304", entrancePoint: CGPoint(x: 240, y: 120)),
        Classroom(name: "305", entrancePoint: CGPoint(x: 290, y: 120)),
        Classroom(name: "306", entrancePoint: CGPoint(x: 340, y: 120)),
        
        Classroom(name: "401", entrancePoint: CGPoint(x: 90, y: 50)),
        Classroom(name: "402", entrancePoint: CGPoint(x: 140, y: 50)),
        Classroom(name: "403", entrancePoint: CGPoint(x: 190, y: 50)),
        Classroom(name: "404", entrancePoint: CGPoint(x: 240, y: 50)),
        Classroom(name: "405", entrancePoint: CGPoint(x: 290, y: 50)),
        Classroom(name: "406", entrancePoint: CGPoint(x: 340, y: 50)),
        
        LargeBuilding(
            name: "GYM",
            entrancePoints: [
                CGPoint(x: 70, y: 190),
                CGPoint(x: 225, y: 240),
                CGPoint(x: 225, y: 300)
            ]
        ),
        
        LargeBuilding(
            name: "CAF",
            entrancePoints: [
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
