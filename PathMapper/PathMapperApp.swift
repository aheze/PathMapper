///  AP CREATE Task
///  PathMapper

import SwiftUI

struct MainView: View {
    
    // MARK: - Static information
    var youAreHerePoint = CGPoint(x: 225, y: 350)
    
    /// list of hallways
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
    
    /// list of classrooms
    let classrooms: [Classroom] = [
        Classroom(name: "PAC", entrancePoints: [CGPoint(x: 70, y: 190), CGPoint(x: 225, y: 240), CGPoint(x: 225, y: 300)]),
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
    
    // MARK: - Output storage
    @State var distance = CGFloat(0)
    @State var points = [CGPoint]()
    @State var pathDrawnPercentage = CGFloat(0) /// for the animation
    
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
                
                // MARK: - Output #1 - Visual line drawn on top of map
                Path { path in
                    if !points.isEmpty {
                        path.move(to: points.first!)
                        for point in points {
                            path.addLine(to: point)
                        }
                    }
                }
                .trim(from: 0, to: pathDrawnPercentage) /// animate path drawing
                .stroke(Color.blue, style: .init(lineWidth: 6, lineCap: .round))
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0.0, y: 0.0)
            }
            .frame(width: 400, height: 400)
            .padding(.vertical, 20)
            .background(Color(.secondarySystemBackground))
            
            VStack {
                HStack {
                    Text("Select a classroom")
                    Spacer()
                    
                    // MARK: - Input #1 - Text input via dropdown
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
                
                // MARK: - Output #2 -  Text displayed showing how many feet and minutes
                Group {
                    if distance != 0 {
                        HStack {
                            Text("Result:").fontWeight(.bold)
                            Spacer()
                            Text("\(NumberToFeet(number: distance)) feet (~\(NumberToFormattedMinutes(number: distance)) min)") /// Concatenate strings
                        }
                        .font(.system(size: 20))
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(16)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 6, trailing: 20))
                    }
                }
                .transition(.scale) /// transition animation
                
                /// tap button to call main function
                Button(action: {
                    
                    /// call the function
                    if let (distance, vertices) = calculateShortestPathTo(classroom: selectedClassroom) {
                        
                        self.points = vertices.map { $0.point }
                        withAnimation { self.distance = distance }
                        withAnimation(.easeOut(duration: 1.5)) { self.pathDrawnPercentage = 1 }
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
        .onChange(of: selectedClassroom, perform: { newValue in /// observe changes of the selected classroom
            withAnimation {
                self.distance = 0 /// remove results if selected classroom changed
                self.pathDrawnPercentage = 0
            }
        })
    }
    
    // MARK: - Functions
    
    /// create vertices based off the `hallways` list
    func getVerticesTo(destinationPoint: CGPoint) -> [Vertex] {
        
        var vertices = [Vertex]() /// will later contain the vertices of the map
        
        /// get the vertex at a point from the `vertices` list. Appends if does not contain
        func vertexAt(point: CGPoint) -> Vertex {
            if let vertex = vertices.first(where: { $0.point == point }) {
                return vertex
            } else {
                let vertex = Vertex(point: point)
                vertices.append(vertex)
                return vertex
            }
        }
        
        var hallways = self.hallways /// create a copy of the `hallways` list
        var foundDestinationHallway = false
        
        for i in hallways.indices {
            if /// check if the hallway contains the destination classroom, if not yet found
                foundDestinationHallway == false && PointIsOnLine(
                    lineStart: hallways[i].start,
                    lineEnd: hallways[i].end,
                    pointToCheck: destinationPoint) == true
            {
                let segmentHallway = DirectionalHallway(start: hallways[i].start, end: destinationPoint)
                hallways[i] = segmentHallway /// replace the full hallway with a portion of the hallway
                
                /// add a hallway that starts at the destination classroom
                let endHallway = DirectionalHallway(start: destinationPoint, end: .zero, length: 0)
                let vertex = vertexAt(point: endHallway.start)
                vertex.touchingHallways.append(endHallway)
                
                foundDestinationHallway = true /// set found to true, so it doesn't check again
            }
            
            /// get the vertex at the hallway's start, and append the hallway to the vertex's neighbors
            let vertex = vertexAt(point: hallways[i].start)
            vertex.touchingHallways.append(hallways[i])
        }
        
        return vertices
    }
    
    /// main function, returns distance and list of vertices
    func calculateShortestPathTo(classroom: Classroom) -> (CGFloat, [Vertex])? {
        
        /// test `classroom` and execute different blocks of code
        if classroom.name == "PAC" || classroom.name == "CAF" { /// classroom is the PAC or CAF
            var currentShortestDistance = CGFloat.infinity
            var currentShortestPath = [Vertex]()
            
            for entrancePoint in classroom.entrancePoints {
                let vertices = getVerticesTo(destinationPoint: entrancePoint)
                
                guard let fromVertex = vertices.first(where: { $0.point == youAreHerePoint }) else { break } /// exit loop if no vertex found
                guard let toVertex = vertices.first(where: { $0.point == entrancePoint }) else { break }
                
                if
                    let (shortestDistance, path) = shortestDistanceAndPath(verticesToCheck: vertices, from: fromVertex, to: toVertex),
                    shortestDistance < currentShortestDistance
                {
                    currentShortestDistance = shortestDistance
                    currentShortestPath = path
                }
            }
            return (currentShortestDistance, currentShortestPath)
            
        } else if Int(classroom.name) != nil { /// classroom name is made of numbers (normal classroom)
            let vertices = getVerticesTo(destinationPoint: classroom.entrancePoints.first!)
            
            guard let fromVertex = vertices.first(where: { $0.point == youAreHerePoint }) else { return nil }
            guard let toVertex = vertices.first(where: { $0.point == classroom.entrancePoints.first! }) else { return nil }
            
            if let (shortestDistance, path) = shortestDistanceAndPath(verticesToCheck: vertices, from: fromVertex, to: toVertex) {
                return (shortestDistance, path)
            }
            
        } else { /// no classroom was selected
            
            let alert = UIAlertController(title: "Select a classroom", message: "You must select a classroom first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true) /// present error alert
        }
        
        return nil /// return nil when IF check fell through without returning - no shortest path was found
    }
    
    /// reusable function to calculate the distance and path
    func shortestDistanceAndPath(verticesToCheck: [Vertex], from: Vertex, to: Vertex) -> (CGFloat, [Vertex])? {
        
        for vertex in verticesToCheck { vertex.visited = false; vertex.distance = CGFloat.infinity }
        from.distance = 0 /// set the first vertex's distance to 0
        var verticesToVisit: [Vertex] = [from]
        
        while verticesToVisit.isEmpty == false {
            
            /// inside verticesToVisit, use vertex with smallest distance
            let currentVisitingVertex = verticesToVisit.min(by: { (a, b) in return a.distance < b.distance })!
            
            if currentVisitingVertex == to { /// if equal to end, done
                var previousVertices = [currentVisitingVertex]
                
                func getPreviousVertex(currentVertex: Vertex) { /// recursive function to trace path backwards
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
            if let firstIndex = verticesToVisit.firstIndex(of: currentVisitingVertex) { verticesToVisit.remove(at: firstIndex) }
            for touchingHallway in currentVisitingVertex.touchingHallways { /// calculate distances of touching hallways
                let endVertex = verticesToCheck.first(where: { $0.point == touchingHallway.end })!
                if endVertex.visited == false {
                    verticesToVisit.append(endVertex)
                    let totalDistance = currentVisitingVertex.distance + touchingHallway.length
                    if totalDistance < endVertex.distance { endVertex.distance = totalDistance; endVertex.previousHallway = touchingHallway}
                }
            }
        }
        
        /// if none found, fall back to return nil
        return nil
    }
}

// MARK: - Helper functions
func DistanceFormula(from: CGPoint, to: CGPoint) -> CGFloat {
    let notSquaredDistance = (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    return sqrt(notSquaredDistance)
}

func PointIsOnLine(lineStart: CGPoint, lineEnd: CGPoint, pointToCheck: CGPoint) -> Bool {
    let xAreSame = pointToCheck.x == lineStart.x && pointToCheck.x == lineEnd.x
    let yAreSame = pointToCheck.y == lineStart.y && pointToCheck.y == lineEnd.y
    
    if xAreSame {
        /// compare Y coordinates now
        let maxY = max(lineStart.y, lineEnd.y)
        let minY = min(lineStart.y, lineEnd.y)
        
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
    
    return false /// if not on the line
}

func NumberToFeet(number: CGFloat) -> Int {
    let feetConversionFactor = CGFloat(1) / CGFloat(2) /// 1 pixel = half feet
    let feet = number * feetConversionFactor
    let feetRounded = Int(feet) /// round to nearest integer
    
    return feetRounded
}
func NumberToFormattedMinutes(number: CGFloat) -> String {
    let minuteConversionFactor = CGFloat(1) / CGFloat(276) /// average walking speed is 276 feet per minute
    let minutes = number * minuteConversionFactor
    let minutesFormatted = String(format: "%.2f", minutes) /// format with 1 decimal place
    
    return minutesFormatted
}


// MARK: - Structures
class DirectionalHallway {
    let start: CGPoint
    let end: CGPoint
    let length: CGFloat
    
    init(start: CGPoint, end: CGPoint, length: CGFloat? = nil) {
        self.start = start
        self.end = end
        
        if let length = length { /// if length is provided, then set
            self.length = length
        } else { /// calculate length if not provided
            self.length = DistanceFormula(from: start, to: end)
        }
    }
}

class Vertex: Equatable {
    let point: CGPoint
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


public struct Ssdasd: View {
    @State var asdasd = false
    public init() {}
    
    public var body: some View {
        Text("")
    }
}
