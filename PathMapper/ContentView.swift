//
//  ContentView.swift
//  PathMapper
//
//  Created by Zheng on 3/26/21.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Static information
    var youAreHere = Vertex(point: CGPoint(x: 225, y: 350))
    
    let hallways: [DirectionalHallway] = [
        
        /// horizontal hallways
        DirectionalHallway(start: CGPoint(x: 30, y: 50), end: CGPoint(x: 370, y: 50)),
        DirectionalHallway(start: CGPoint(x: 370, y: 120), end: CGPoint(x: 225, y: 120)),
        DirectionalHallway(start: CGPoint(x: 225, y: 120), end: CGPoint(x: 30, y: 120)),
        DirectionalHallway(start: CGPoint(x: 30, y: 190), end: CGPoint(x: 225, y: 190)),
        DirectionalHallway(start: CGPoint(x: 225, y: 190), end: CGPoint(x: 370, y: 190)),
        DirectionalHallway(start: CGPoint(x: 370, y: 350), end: CGPoint(x: 225, y: 350)),
        DirectionalHallway(start: CGPoint(x: 225, y: 350), end: CGPoint(x: 30, y: 350)),
        
        /// vertical hallways
        DirectionalHallway(start: CGPoint(x: 30, y: 120), end: CGPoint(x: 30, y: 50)),
        DirectionalHallway(start: CGPoint(x: 30, y: 190), end: CGPoint(x: 30, y: 120)),
        DirectionalHallway(start: CGPoint(x: 30, y: 350), end: CGPoint(x: 30, y: 190)),
        DirectionalHallway(start: CGPoint(x: 225, y: 190), end: CGPoint(x: 225, y: 120)),
        DirectionalHallway(start: CGPoint(x: 225, y: 350), end: CGPoint(x: 225, y: 190)),
        DirectionalHallway(start: CGPoint(x: 370, y: 50), end: CGPoint(x: 370, y: 120)),
        DirectionalHallway(start: CGPoint(x: 370, y: 120), end: CGPoint(x: 370, y: 190)),
        DirectionalHallway(start: CGPoint(x: 370, y: 190), end: CGPoint(x: 370, y: 350))
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
        Classroom(name: "GYM", entrancePoints: [CGPoint(x: 70, y: 190), CGPoint(x: 225, y: 240), CGPoint(x: 225, y: 300)]),
        Classroom(name: "CAF", entrancePoints: [CGPoint(x: 225, y: 270), CGPoint(x: 270, y: 230)])
    ]
    
    // MARK: - User input storage
    @State var selectedClassroom = Classroom(name: "Select a classroom", entrancePoints: [])
    
    // MARK: - User interface
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
                    calculateShortestPathTo(classroom: selectedClassroom)
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
    
    // MARK: - Functions
    func calculateShortestPathTo(classroom: Classroom) {
        print("classroom: \(classroom)")
        
        /// create an empty Vertex array
        var vertices = [Vertex]()
        
        func vertexAt(point: CGPoint) -> Vertex {
            if let vertex = vertices.first(where: { $0.point == point }) {
                return vertex
            } else {
                let vertex = Vertex(point: point)
                vertices.append(vertex)
                return vertex
            }
        }
        
        var hallways = self.hallways
        if let classroomHallwayIndex = hallways.firstIndex(where: { CGPointIsOnLine(lineStart: $0.start, lineEnd: $0.end, pointToCheck: classroom.entrancePoints.first!) }) {
            let hallway = hallways[classroomHallwayIndex]
            
            print("Hallway start: \(hallway.start), classroom: \(classroom.entrancePoints.first!)")
            let newHallway = DirectionalHallway(start: hallway.start, end: classroom.entrancePoints.first!)
            let endHallway = DirectionalHallway(start: classroom.entrancePoints.first!, end: .zero, weight: 0)
            
            print("new wright: \(newHallway.weight)")
            print("End weight: \(endHallway.weight)")
            
            hallways.remove(at: classroomHallwayIndex)
            hallways.append(newHallway)
            hallways.append(endHallway)
        }
        
        for hallway in hallways {
            let vertex = vertexAt(point: hallway.start)
            vertex.touchingHallways.append(hallway)
        }
        
        
        func distance(from: CGPoint, to: CGPoint) -> CGFloat? {
            
            guard let fromVertex = vertices.first(where: { $0.point == from }) else {
                return nil
            }
            guard let toVertex = vertices.first(where: { $0.point == to }) else {
                return nil
            }
            
            for vertex in vertices {
                vertex.visited = false
                vertex.distance = CGFloat.infinity
            }
            
            fromVertex.distance = 0
            var verticesToVisit: [Vertex] = [fromVertex]
            
            while !verticesToVisit.isEmpty {
                print("---- current vertices to visit: \(verticesToVisit.map {$0.point })")
                
                // Select node with smallest distance.
                let currentVisitingVertex = verticesToVisit.min(by: { (a, b) -> Bool in
                    return a.distance < b.distance
                })!
                
                print("Current point \(currentVisitingVertex.point)")
                
                // Destination reached?
                if currentVisitingVertex == toVertex { return currentVisitingVertex.distance }
                
                // Mark as visited.
                currentVisitingVertex.visited = true
                
                
                if let firstIndex = verticesToVisit.firstIndex(of: currentVisitingVertex) {
                    verticesToVisit.remove(at: firstIndex)
                }
                
                // Update unvisited neighbors.
                for touchingHallway in currentVisitingVertex.touchingHallways {
                    print("Touching end: \(touchingHallway.end)")
                    let endVertex = vertexAt(point: touchingHallway.end)
                    if endVertex.visited == false {
                        verticesToVisit.append(endVertex)
                        
                        print("Current visiting vertex distance \(currentVisitingVertex.distance). Weight of touching hallway \(touchingHallway.weight) ... end \(touchingHallway.end)")
                        
                        let totalDistance = currentVisitingVertex.distance + touchingHallway.weight
                        if totalDistance < endVertex.distance {
                            endVertex.distance = totalDistance
                        }
                    }
                }
            }
            
            return nil
        }
        
        
        let totalDistance = distance(from: youAreHere.point, to: classroom.entrancePoints.first!)
        print("---- DIST ----- \(totalDistance)")
        
        
        if classroom.name == "GYM" || classroom.name == "CAF" {
            print("Spacial")
        } else if let number = Int(classroom.name) {
            print("number.. \(number)")
        } else {
            print("Nope")
        }
        print("!    done")
    }
    
    
   
}

// MARK: - Helper functions
func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
    let notSquaredDistance = (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    return sqrt(notSquaredDistance)
}

func CGPointIsOnLine(lineStart: CGPoint, lineEnd: CGPoint, pointToCheck: CGPoint) -> Bool {
    let xAreSame = pointToCheck.x == lineStart.x && pointToCheck.x == lineEnd.x
    let yAreSame = pointToCheck.y == lineStart.y && pointToCheck.y == lineEnd.y
    
    if xAreSame {
        /// compare Y coordinates now
        let maxY = max(lineStart.y, lineEnd.y)
        let minY = min(lineStart.y, lineEnd.y)
        
        print("X Same. Comparing Y bounds: min \(minY) point \(pointToCheck.x) max \(maxY)")
        
        if pointToCheck.y <= maxY && pointToCheck.y >= minY {
            return true
        }
    } else if yAreSame {
        /// compare X coordinates now
        let maxX = max(lineStart.x, lineEnd.x)
        let minX = min(lineStart.x, lineEnd.x)
        
        if pointToCheck.x <= maxX && pointToCheck.x >= minX {
            return true
        }
    }
    
    return false
}

// MARK: - Structures
class DirectionalHallway {
    var start: CGPoint
    var end: CGPoint
    let weight: CGFloat
    
    init(start: CGPoint, end: CGPoint, weight: CGFloat? = nil) {
        self.start = start
        self.end = end
        
        if let weight = weight { /// if weight is provided, then set
            self.weight = weight
        } else { /// calculate weight if not provided
            self.weight = CGPointDistanceSquared(from: start, to: end)
        }
    }
}

class Vertex: Equatable {
    var point: CGPoint
    var distance = CGFloat.infinity
    var touchingHallways = [DirectionalHallway]()
    var visited = false
    
    init(point: CGPoint) {
        self.point = point
    }
    
    static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs === rhs
    }
    
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

// MARK: - Testing
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



