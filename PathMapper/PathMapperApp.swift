///  AP CREATE Task
///  PathMapper

import SwiftUI

struct MainView: View {
    
    // MARK: - Static Information
    let youAreHerePoint = CGPoint(x: 225, y: 350)
    
    ///### 3B i. (Row 2) - list of hallways
    let hallways = [
        
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
    let classrooms = [
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
    
    // MARK: - User Input Storage
    @State var selectedClassroom = Classroom(name: "Tap here!", entrancePoints: [])
    
    // MARK: - Output Storage
    @State var resultDistance = CGFloat(0)
    @State var mapPathVertices = [Vertex]()
    @State var mapPathDrawnPercentage = CGFloat(0)
    
    // MARK: - User Interface
    var body: some View {
        VStack {
            
            Text("PathMapper")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .padding(.horizontal, 12)
            
            Text("Find the shortest route to a classroom, but follow the directional arrows!")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
            
            ZStack {
                Image("Map") /// the map image
                    .resizable()
                
                // MARK: - Visual Output, path drawn on top of map
                Path { path in
                    if mapPathVertices.isEmpty == false {
                        path.move(to: mapPathVertices.first!.point)
                        for vertex in mapPathVertices {
                            path.addLine(to: vertex.point)
                        }
                    }
                }
                .trim(from: 0, to: mapPathDrawnPercentage) /// animate path drawing
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0.0, y: 0.0)
            }
            .frame(width: 400, height: 400)
            .padding(.vertical, 20)
            .background(Color(.secondarySystemBackground))
            
            VStack {
                HStack {
                    Text("Select a classroom")
                    Spacer()
                    
                    // MARK: - Text Input via dropdown
                    Picker(selectedClassroom.name, selection: $selectedClassroom) {
                        ForEach(classrooms, id: \.self) { classroom in
                            Text(classroom.name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .font(.system(size: 21))
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal, 20)
                
                // MARK: - Text Output, show the distance and approximate time needed
                Group {
                    if resultDistance != 0 {
                        HStack {
                            Text("Result:").fontWeight(.bold)
                            Spacer()
                            Text("\(NumberToFeet(number: resultDistance)) feet (~\(NumberToMinutes(number: resultDistance)) min)") /// Concatenate strings
                        }
                        .font(.system(size: 20))
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                    }
                }
                .transition(.scale) /// transition animation
                
                /// tap button to call main procedure
                Button(action: {
                    
                    ///### 3C ii. (Row 4) - call the procedure
                    if let (distance, vertices) = calculateShortestPathTo(classroom: selectedClassroom) {
                        withAnimation {
                            mapPathVertices = vertices
                            resultDistance = distance
                            mapPathDrawnPercentage = 1
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
        /// remove results if selected classroom changed
        .onChange(of: selectedClassroom) { _ in
            withAnimation {
                resultDistance = 0
                mapPathVertices.removeAll()
                mapPathDrawnPercentage = 0
            }
        }
    }
    
    // MARK: - Procedures
    
    /// get vertices of all possible paths to a destination
    func getVerticesTo(destinationPoint: CGPoint) -> [Vertex] {
        
        ///### 3B ii. (Row 3) - create new vertices from the `hallways` list
        var vertices = [Vertex]() /// vertices for the shortest-path algorithm
        func vertexAt(point: CGPoint) -> Vertex {
            if let vertex = vertices.first(where: { $0.point == point }) {
                return vertex /// return existing vertex in the `vertices` list
            } else {
                let vertex = Vertex(point: point)
                vertices.append(vertex)
                return vertex /// return a new vertex and append to the `vertices` list
            }
        }
        
        // MARK: First create a copy of the `hallways` list
        var hallwaysCopy = hallways
        var foundDestinationHallway = false
        
        // MARK: Create vertices from hallways (new data from existing data)
        for i in hallwaysCopy.indices {
            if /// check if the hallway contains the destination classroom
                foundDestinationHallway == false && PointIsOnLine(
                    lineStart: hallwaysCopy[i].start,
                    lineEnd: hallwaysCopy[i].end,
                    pointToCheck: destinationPoint) == true
            {
                let segmentHallway = DirectionalHallway(start: hallwaysCopy[i].start, end: destinationPoint)
                hallwaysCopy[i] = segmentHallway /// replace the full hallway with a portion of the hallway
                
                /// append hallway that starts at the destination classroom's entrance
                let endHallway = DirectionalHallway(start: destinationPoint, end: .zero, length: 0)
                let vertex = vertexAt(point: endHallway.start) /// get the vertex at the hallway's start
                vertex.touchingHallways.append(endHallway) /// append the hallway to the vertex's neighbors
                
                foundDestinationHallway = true /// set found to true, so it doesn't check again
            }
            
            let vertex = vertexAt(point: hallwaysCopy[i].start) /// get the vertex at the hallway's start
            vertex.touchingHallways.append(hallwaysCopy[i]) /// append the hallway to the vertex's neighbors
        }
        
        return vertices
    }
    
    ///### 3C i. (Row 4) - main procedure, get a classroom's distance and list of vertices
    func calculateShortestPathTo(classroom: Classroom) -> (CGFloat, [Vertex])? {
        
        /// **selection**
        /// test `classroom` to run different blocks of code
        if classroom.name == "PAC" || classroom.name == "CAF" { /// classroom is the PAC or CAF
            var currentShortestDistance = CGFloat.infinity
            var currentShortestPath = [Vertex]()
            
            /// **iteration**
            for entrancePoint in classroom.entrancePoints {
                let vertices = getVerticesTo(destinationPoint: entrancePoint)
                
                if
                    let fromVertex = vertices.first(where: { $0.point == youAreHerePoint }),
                    let toVertex = vertices.first(where: { $0.point == entrancePoint }),
                    let (shortestDistance, shortestPath) = ShortestDistanceAndPath(verticesToCheck: vertices, from: fromVertex, to: toVertex),
                    shortestDistance < currentShortestDistance
                {
                    currentShortestDistance = shortestDistance
                    currentShortestPath = shortestPath
                }
            }
            return (currentShortestDistance, currentShortestPath)
            
        } else if Int(classroom.name) != nil { /// classroom name is made of numbers (normal classroom)
            /// **sequencing**
            let vertices = getVerticesTo(destinationPoint: classroom.entrancePoints.first!)
            
            if
                let fromVertex = vertices.first(where: { $0.point == youAreHerePoint }),
                let toVertex = vertices.first(where: { $0.point == classroom.entrancePoints.first! }),
                let (shortestDistance, shortestPath) = ShortestDistanceAndPath(verticesToCheck: vertices, from: fromVertex, to: toVertex)
            {
                return (shortestDistance, shortestPath)
            }
            
        } else { /// no classroom was selected
            let alert = UIAlertController(title: "Select a classroom", message: "You must select a classroom first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            UIApplication.shared.windows.first{$0.isKeyWindow}?.rootViewController?.present(alert, animated: true) /// present error alert
        }
        
        return nil /// return nothing when if check fell through - no shortest path was found
    }
    
}

// MARK: - Helper Procedures

/// the distance formula
func DistanceFormula(from: CGPoint, to: CGPoint) -> CGFloat {
    let notSquaredDistance = (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    return sqrt(notSquaredDistance)
}

/// check if a point falls on the line between 2 points
func PointIsOnLine(lineStart: CGPoint, lineEnd: CGPoint, pointToCheck: CGPoint) -> Bool {
    let xAreSame = pointToCheck.x == lineStart.x && pointToCheck.x == lineEnd.x
    let yAreSame = pointToCheck.y == lineStart.y && pointToCheck.y == lineEnd.y
    
    if xAreSame {
        let maxY = max(lineStart.y, lineEnd.y)
        let minY = min(lineStart.y, lineEnd.y)
        if pointToCheck.y <= maxY && pointToCheck.y >= minY { /// compare Y coordinates
            return true
        }
    } else if yAreSame {
        let maxX = max(lineStart.x, lineEnd.x)
        let minX = min(lineStart.x, lineEnd.x)
        if pointToCheck.x <= maxX && pointToCheck.x >= minX { /// compare X coordinates
            return true
        }
    }
    return false /// not on the line
}

/// calculate the distance and path
/// adapted from https://codereview.stackexchange.com/a/212585 (CC BY-SA 4.0)
func ShortestDistanceAndPath(verticesToCheck: [Vertex], from: Vertex, to: Vertex) -> (CGFloat, [Vertex])? {
    
    for vertex in verticesToCheck { vertex.visited = false; vertex.distance = CGFloat.infinity }
    var verticesToVisit: [Vertex] = [from]
    from.distance = 0 /// set the first vertex's distance to 0
    
    while verticesToVisit.isEmpty == false {
        
        /// inside `verticesToVisit`, use vertex with smallest distance
        let currentVisitingVertex = verticesToVisit.min(by: { (a, b) in return a.distance < b.distance })!
        
        if currentVisitingVertex == to { /// if vertex is at destination, done!
            var previousVertices = [currentVisitingVertex]
            
            func getPreviousVertex(currentVertex: Vertex) { /// recursive procedure to trace path backwards
                if let previousHallway = currentVertex.previousHallway {
                    let previousVertex = verticesToCheck.first(where: { $0.point == previousHallway.start })!
                    previousVertices.insert(previousVertex, at: 0) /// insert previous vertex at beginning of list
                    getPreviousVertex(currentVertex: previousVertex)
                }
            }
            getPreviousVertex(currentVertex: currentVisitingVertex)
            return (currentVisitingVertex.distance, previousVertices) /// exit the `while` loop and return the shortest distance and path
        }
        
        /// set vertex to visited
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
    
    return nil /// if none found, fall back to return nothing
}

/// convert on-screen distance to feet
func NumberToFeet(number: CGFloat) -> String {
    let feetConversionFactor = CGFloat(1) / CGFloat(2) /// 1 pixel = half feet
    let feet = number * feetConversionFactor
    let feetRounded = Int(feet) /// round to nearest integer
    
    return "\(feetRounded)"
}
/// convert on-screen distance to average walking duration
func NumberToMinutes(number: CGFloat) -> String {
    let minuteConversionFactor = CGFloat(1) / CGFloat(276) /// average walking speed is 276 feet per minute
    let minutes = number * minuteConversionFactor
    let minutesFormatted = String(format: "%.2f", minutes) /// format with 1 decimal place
    
    return minutesFormatted
}

// MARK: - Structures
class Vertex: Equatable {
    let point: CGPoint
    var distance = CGFloat.infinity
    var touchingHallways = [DirectionalHallway]()
    
    var visited = false
    var previousHallway: DirectionalHallway?
    
    init(point: CGPoint) { self.point = point}
    static func == (lhs: Vertex, rhs: Vertex) -> Bool { return lhs === rhs }
}
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
struct Classroom: Identifiable, Hashable {
    var name: String
    var entrancePoints: [CGPoint]
    
    let id = UUID()
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

// MARK: - Run The Code
@main
struct PathMapperApp: App {
    var body: some Scene {
        WindowGroup {
            MainView() /// run the `MainView` here
        }
    }
}
