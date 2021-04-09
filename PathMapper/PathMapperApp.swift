//
//  PathMapperApp.swift
//  PathMapper
//
//  Created by Zheng on 3/26/21.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Static information
    var youAreHerePoint = CGPoint(x: 225, y: 350)
    
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
        Classroom(name: "GYM", entrancePoints: [CGPoint(x: 70, y: 190), CGPoint(x: 225, y: 240), CGPoint(x: 225, y: 300)]),
        Classroom(name: "CAF", entrancePoints: [CGPoint(x: 225, y: 270), CGPoint(x: 270, y: 230)]),
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
        Classroom(name: "406", entrancePoints: [CGPoint(x: 340, y: 50)])
    ]
    
    // MARK: - User input storage
    @State var selectedClassroom = Classroom(name: "Tap here!", entrancePoints: [])
    
    // MARK: - Output
    @State var distance = CGFloat(0)
    @State var points = [CGPoint]()
    @State var pathDrawnPercentage = CGFloat(0)
    
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
                Image("Map")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400, height: 400)
                
                
                Path { path in
                    
                    if !points.isEmpty {
                        
                        path.move(to: points.first!)
                        
                        for point in points {
                            path.addLine(to: point)
                        }
                        
                    }
                }
                .trim(from: 0, to: pathDrawnPercentage)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0.0, y: 0.0)
                .frame(width: 400, height: 400)
            }
            .padding(.vertical, 20)
            .background(
                Color(.secondarySystemBackground)
            )
            
            VStack {
                
                HStack {
                    Text("Select a classroom")
                    
                    Spacer()
                    
                    Picker(selectedClassroom.name, selection: $selectedClassroom) {
                        ForEach(classrooms, id: \.self) { classroom in
                            Text(classroom.name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(.blue)
                    
                }
                .font(.system(size: 20))
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                
                Group {
                    if distance != 0 {
                        HStack {
                            Text("Result:")
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text("\(distance.toFeet()) feet (~\(distance.toFormattedMinutes()) min)")
                            
                        }
                        .font(.system(size: 20))
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(16)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 6, trailing: 20))
                    }
                }
                .transition(.scale)
                
                Button(action: {
                    if let (distance, vertices) = calculateShortestPathTo(classroom: selectedClassroom) {
                        self.points = vertices.map { $0.point }
                        withAnimation {
                            self.distance = distance
                        }
                        withAnimation(.easeOut(duration: 1.5)) {
                            self.pathDrawnPercentage = 1
                        }
                        
                    }
                }) {
                    Text("Calculate")
                        .font(.system(size: 21, weight: .medium))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(16)
                }
            }
            
            Spacer()
            
        }
        .onChange(of: selectedClassroom, perform: { newValue in
            withAnimation {
                self.distance = 0 /// hide results if Classroom changed
                self.pathDrawnPercentage = 0
            }
        })
    }
    
    // MARK: - Functions
    func getVerticesTo(destinationPoint: CGPoint) -> [Vertex] {
        /// will later contain the vertices of the map
        var vertices = [Vertex]()
        
        /// get the vertex at a point from the `vertices` array. Appends if does not contain
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
        if let classroomHallwayIndex = hallways.firstIndex(where: { CGPointIsOnLine(lineStart: $0.start, lineEnd: $0.end, pointToCheck: destinationPoint) }) {
            let hallway = hallways[classroomHallwayIndex]
            
            let newHallway = DirectionalHallway(start: hallway.start, end: destinationPoint)
            let endHallway = DirectionalHallway(start: destinationPoint, end: .zero, weight: 0)
            
            hallways.remove(at: classroomHallwayIndex)
            hallways.append(newHallway)
            hallways.append(endHallway)
        }
        
        for hallway in hallways {
            let vertex = vertexAt(point: hallway.start)
            vertex.touchingHallways.append(hallway)
        }
        
        return vertices
    }
    
    func calculateShortestPathTo(classroom: Classroom) -> (CGFloat, [Vertex])? {
        print("classroom: \(classroom)")
        
        /// return the distance and the path of vertices
        func distance(verticesToCheck: [Vertex], from: Vertex, to: Vertex) -> (CGFloat, [Vertex])? {
            
            for vertex in verticesToCheck {
                vertex.visited = false
                vertex.distance = CGFloat.infinity
            }
            
            from.distance = 0
            var verticesToVisit: [Vertex] = [from]
            
            while !verticesToVisit.isEmpty {
                
                /// out of verticesToVisit, use vertex with smallest distance
                let currentVisitingVertex = verticesToVisit.min(by: { (a, b) -> Bool in
                    return a.distance < b.distance
                })!
                
                /// if equal to end, done
                if currentVisitingVertex == to {
                    var previousVertices = [currentVisitingVertex]
                    func getPreviousVertex(currentVertex: Vertex) {
                        if let previousHallway = currentVertex.previousHallway {
                            let previousVertex = verticesToCheck.first(where: { $0.point == previousHallway.start })!
                            previousVertices.insert(previousVertex, at: 0) /// insert previous vertex at beginning
                            getPreviousVertex(currentVertex: previousVertex)
                        }
                    }
                    
                    getPreviousVertex(currentVertex: currentVisitingVertex)
                    
                    return (currentVisitingVertex.distance, previousVertices) /// exit the `while` loop
                }
                
                /// set current vertex to visited
                currentVisitingVertex.visited = true
                
                
                if let firstIndex = verticesToVisit.firstIndex(of: currentVisitingVertex) {
                    verticesToVisit.remove(at: firstIndex)
                }
                
                /// calculate distances of touching hallways
                for touchingHallway in currentVisitingVertex.touchingHallways {
                    let endVertex = verticesToCheck.first(where: { $0.point == touchingHallway.end })!
                    if endVertex.visited == false {
                        verticesToVisit.append(endVertex)
                        
                        let totalDistance = currentVisitingVertex.distance + touchingHallway.weight
                        if totalDistance < endVertex.distance {
                            endVertex.distance = totalDistance
                            endVertex.previousHallway = touchingHallway
                        }
                    }
                }
            }
            
            /// if none found, fall back to return nil
            return nil
        }
        
        if classroom.name == "GYM" || classroom.name == "CAF" {
            var currentShortestDistance = CGFloat.infinity
            var currentShortestPath = [Vertex]()
            
            for entrancePoint in classroom.entrancePoints {
                let vertices = getVerticesTo(destinationPoint: entrancePoint)
                
                guard let fromVertex = vertices.first(where: { $0.point == youAreHerePoint }) else { break } /// exit loop if no vertex found
                guard let toVertex = vertices.first(where: { $0.point == entrancePoint }) else { break }
                
                if let (shortestDistance, path) = distance(verticesToCheck: vertices, from: fromVertex, to: toVertex) {
                    if shortestDistance < currentShortestDistance {
                        currentShortestDistance = shortestDistance
                        currentShortestPath = path
                    }
                }
            }
            
            return (currentShortestDistance, currentShortestPath)
        } else if Int(classroom.name) != nil {
            let vertices = getVerticesTo(destinationPoint: classroom.entrancePoints.first!)
            
            guard let fromVertex = vertices.first(where: { $0.point == youAreHerePoint }) else { return nil }
            guard let toVertex = vertices.first(where: { $0.point == classroom.entrancePoints.first! }) else { return nil }
            let totalDistance = distance(verticesToCheck: vertices, from: fromVertex, to: toVertex)
            
            return totalDistance
        }
        
        return nil /// return nil if failed
        
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

extension CGFloat {
    func toFeet() -> Int {
        let feetConversionFactor = CGFloat(1) / CGFloat(2) /// 1 pixel = half feet
        let feet = self * feetConversionFactor
        let feetRounded = Int(feet) /// round to nearest integer
        
        return feetRounded
    }
    
    func toFormattedMinutes() -> String {
        let minuteConversionFactor = CGFloat(1) / CGFloat(276) /// average walking speed is 276 feet per minute
        let minutes = self * minuteConversionFactor
        let minutesFormatted = String(format: "%.2f", minutes) /// format with 1 decimal place
        
        return minutesFormatted
    }
    
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
    var previousHallway: DirectionalHallway?
    
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


// MARK: - Run the code
@main
struct PathMapperApp: App {
    var body: some Scene {
        WindowGroup {
            MainView() /// make the `MainView` here
        }
    }
}
