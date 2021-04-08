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
    
    struct Classroom: Identifiable, Hashable {
        let id = UUID()
        
        var name: String
        var entrancePoints: [CGPoint]
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        static func ==(lhs: Classroom, rhs: Classroom) -> Bool {
            return lhs.id == rhs.id
        }
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
        CGPoint(x: 225, y: 350), /// you are here
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
    
    let classrooms: [Classroom] = [
        Classroom(name: "101", entrancePoints: [CGPoint(x: 90, y: 350)]),
        Classroom(name: "102", entrancePoints: [CGPoint(x: 140, y: 350)]),
        Classroom(name: "103", entrancePoints: [CGPoint(x: 190, y: 350)]),
        Classroom(name: "104", entrancePoints: [CGPoint(x: 290, y: 350)]),
        Classroom(name: "105", entrancePoints: [CGPoint(x: 340, y: 350)]),
        
        Classroom(name: "201", entrancePoints: [CGPoint(x: 90, y: 190)]),
        Classroom(name: "202", entrancePoints: [CGPoint(x: 140, y: 190)]),
        Classroom(name: "203", entrancePoints: [CGPoint(x: 190, y: 190)]),
        Classroom(name: "204", entrancePoints: [CGPoint(x: 290, y: 190)]),
        Classroom(name: "205", entrancePoints: [CGPoint(x: 340, y: 190)]),
        
        Classroom(name: "301", entrancePoints: [CGPoint(x: 90, y: 120)]),
        Classroom(name: "302", entrancePoints: [CGPoint(x: 140, y: 120)]),
        Classroom(name: "303", entrancePoints: [CGPoint(x: 190, y: 120)]),
        Classroom(name: "304", entrancePoints: [CGPoint(x: 240, y: 120)]),
        Classroom(name: "305", entrancePoints: [CGPoint(x: 290, y: 120)]),
        Classroom(name: "306", entrancePoints: [CGPoint(x: 340, y: 120)]),
        
        Classroom(name: "401", entrancePoints: [CGPoint(x: 90, y: 50)]),
        Classroom(name: "402", entrancePoints: [CGPoint(x: 140, y: 50)]),
        Classroom(name: "403", entrancePoints: [CGPoint(x: 190, y: 50)]),
        Classroom(name: "404", entrancePoints: [CGPoint(x: 240, y: 50)]),
        Classroom(name: "405", entrancePoints: [CGPoint(x: 290, y: 50)]),
        Classroom(name: "406", entrancePoints: [CGPoint(x: 340, y: 50)]),
        
        Classroom(
            name: "GYM",
            entrancePoints: [
                CGPoint(x: 70, y: 190),
                CGPoint(x: 225, y: 240),
                CGPoint(x: 225, y: 300)
            ]
        ),
        
        Classroom(
            name: "CAF",
            entrancePoints: [
                CGPoint(x: 225, y: 270),
                CGPoint(x: 270, y: 230)
            ]
        )
    ]
    
    @State var selectedClassroom = Classroom(name: "Select a classroom", entrancePoints: [])
    
    var body: some View {
        VStack {
            
            Text("PathMapper")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 3, trailing: 12))
            
            Text("Find the shortest route to a classroom")
                .fontWeight(.medium)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 6, trailing: 12))
            
            
            ZStack {
                Color(.secondarySystemBackground)
                    .frame(width: 400, height: 400)
                
                Image("Hallways")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400, height: 400)
                
                
                MapView()
            }
            .padding(.vertical, 10)
            
            
            VStack {
                Picker(selectedClassroom.name, selection: $selectedClassroom) {
                    ForEach(classrooms, id: \.self) { classroom in
                        Text(classroom.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.blue)
                .padding(.vertical, 6)
                
                
                Button(action: {
                    calculateSelection()
                }) {
                    Text("Calculate")
                        .font(.system(size: 21, weight: .medium))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(16)
                }
            }
            
        }
    }
    
    func calculateSelection() {
        print("classroom: \(selectedClassroom)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


