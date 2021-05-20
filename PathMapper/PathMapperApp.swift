///  AP Computer Science Principles - CREATE Performance Task
///  "PathMapper" - Find the shortest route to a classroom, but follow the directional arrows!
///  Written in the Swift programming language. An iOS app.

import SwiftUI

struct MainView: View {
    
    // MARK: - Constants
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
        Classroom(name: "406", entrancePoint: CGPoint(x: 340, y: 50))
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
            
            Text("Find the shortest route to a classroom, but follow the directional arrows!")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
            
            ZStack {
                Image("Map").resizable() /// the map image (made by myself)
                    
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
                .shadow(color: Color.black.opacity(0.3), radius: 3)
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
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                
                // MARK: - Text Output, show the distance and approximate time needed
                if resultDistance != 0 {
                    HStack {
                        Text("Result:").fontWeight(.bold)
                        Spacer()
                        Text("\(NumberToFeet(number: resultDistance)) feet (~\(NumberToMinutes(number: resultDistance)) min)") /// Concatenate strings
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                }
                
                /// tap button to call main procedure
                Button(action: {
                    
                    ///### 3C ii. (Row 4) - call the procedure
                    if let route = shortestRouteTo(classroom: selectedClassroom) {
                        withAnimation {
                            resultDistance = route.distance
                            mapPathVertices = route.path
                            mapPathDrawnPercentage = 1
                        }
                    }
                }) {
                    Text("Calculate")
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(16)
                }
            }
            .font(.system(size: 20, weight: .medium))
            .padding(.horizontal, 20)
            
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
    
    /// get list of vertices (represents all possible paths) to a destination
    func getVerticesTo(destinationPoint: CGPoint) -> [Vertex] {
        
        ///### 3B ii. (Row 2) - create `vertices` list from `hallways` list
        var vertices = [Vertex]()
        
        /// get and append a hallway's corresponding vertex to `vertices`, then append the hallway to the vertex's `touchingHallways`
        func configureVertexWith(hallway: DirectionalHallway) {
            var vertex: Vertex
            if let existingVertex = vertices.first(where: { $0.point == hallway.start }) {
                vertex = existingVertex /// prevent duplicates, get existing vertex in the `vertices` list
            } else {
                vertex = Vertex(point: hallway.start) /// create new vertex
                vertices.append(vertex) /// append to `vertices` list
            }
            vertex.touchingHallways.append(hallway)
        }
        
        var hallwaysCopy = hallways /// create mutable copy
        for i in hallwaysCopy.indices {
            if PointIsOnLine(lineStart: hallwaysCopy[i].start, lineEnd: hallwaysCopy[i].end, point: destinationPoint) {
                hallwaysCopy[i] = DirectionalHallway(start: hallwaysCopy[i].start, end: destinationPoint) /// replace full hallway with a portion
                configureVertexWith(hallway: DirectionalHallway(start: destinationPoint, end: destinationPoint)) /// final hallway, length of 0
            }
            configureVertexWith(hallway: hallwaysCopy[i])
        }
        
        return vertices
    }
    
    ///### 3C i. (Row 4) - main procedure, get shortest route (distance and path) to classroom
    func shortestRouteTo(classroom: Classroom) -> Route? {
        
        /// **selection**
        if classroom.name == "PAC" || classroom.name == "CAF" { /// classroom is either PAC or CAF
            var currentShortestRoute = Route(distance: .infinity, path: [])
            /// **iteration**
            for entrancePoint in classroom.entrancePoints {
                let vertices = getVerticesTo(destinationPoint: entrancePoint)
                if
                    let shortestRoute = ShortestRouteFromVertices(vertices: vertices, start: youAreHerePoint, end: entrancePoint),
                    shortestRoute.distance < currentShortestRoute.distance
                {
                    currentShortestRoute = shortestRoute
                }
            }
            return currentShortestRoute
        } else if Int(classroom.name) != nil { /// classroom name is made of numbers (normal classroom)
            /// **sequencing**
            let vertices = getVerticesTo(destinationPoint: classroom.entrancePoint)
            if let shortestRoute = ShortestRouteFromVertices(vertices: vertices, start: youAreHerePoint, end: classroom.entrancePoint) {
                return shortestRoute
            }
        } else { /// no classroom was selected
            let alert = UIAlertController(title: "Select a classroom", message: "You must select a classroom first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.present(alert, animated: true) /// present error alert
        }
        
        return nil /// return nothing when if check fell through - no shortest path was found
    }
    
}

// MARK: - Helper Procedures

/// the distance formula
func DistanceFormula(from: CGPoint, to: CGPoint) -> CGFloat {
    let squaredDistance = (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    return sqrt(squaredDistance)
}

/// check if a point falls on the line between 2 points
func PointIsOnLine(lineStart: CGPoint, lineEnd: CGPoint, point: CGPoint) -> Bool {
    let xAreSame = (point.x == lineStart.x && point.x == lineEnd.x)
    let yAreSame = (point.y == lineStart.y && point.y == lineEnd.y)
    
    if xAreSame {
        let maxY = max(lineStart.y, lineEnd.y)
        let minY = min(lineStart.y, lineEnd.y)
        if point.y <= maxY && point.y >= minY { /// compare Y coordinates
            return true
        }
    } else if yAreSame {
        let maxX = max(lineStart.x, lineEnd.x)
        let minX = min(lineStart.x, lineEnd.x)
        if point.x <= maxX && point.x >= minX { /// compare X coordinates
            return true
        }
    }
    return false /// not on the line
}

/// calculate the shortest route from a list of vertices
/// adapted from https://codereview.stackexchange.com/a/212585 (CC BY-SA 4.0)
/// reference: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm (CC BY-SA 3.0)
func ShortestRouteFromVertices(vertices: [Vertex], start: CGPoint, end: CGPoint) -> Route? {
    
    /// use built-in `first(where:)` procedure to get vertex at point
    let startVertex = vertices.first(where: { $0.point == start })!
    let endVertex = vertices.first(where: { $0.point == end })
    
    for vertex in vertices { vertex.visited = false; vertex.distance = CGFloat.infinity }
    var verticesToVisit: [Vertex] = [startVertex]
    startVertex.distance = 0 /// set the first vertex's distance to 0
    
    while verticesToVisit.isEmpty == false {
        
        /// inside `verticesToVisit`, use vertex with smallest distance
        let currentVisitingVertex = verticesToVisit.min(by: { (a, b) in return a.distance < b.distance })!
        if currentVisitingVertex == endVertex { /// if vertex is at destination, done!
            var path = [currentVisitingVertex]
            func getPreviousVertex(currentVertex: Vertex) { /// recursive procedure to trace path backwards
                if let previousHallway = currentVertex.previousHallway {
                    let previousVertex = vertices.first(where: { $0.point == previousHallway.start })!
                    path.insert(previousVertex, at: 0) /// insert previous vertex at beginning of list
                    getPreviousVertex(currentVertex: previousVertex)
                }
            }
            getPreviousVertex(currentVertex: currentVisitingVertex)
            return Route(distance: currentVisitingVertex.distance, path: path) /// exit the `while` loop and return the shortest distance and path
        }
        
        /// set vertex to visited
        currentVisitingVertex.visited = true
        if let firstIndex = verticesToVisit.firstIndex(of: currentVisitingVertex) { verticesToVisit.remove(at: firstIndex) }
        
        for touchingHallway in currentVisitingVertex.touchingHallways { /// calculate distances of touching hallways
            let endVertex = vertices.first(where: { $0.point == touchingHallway.end })!
            if endVertex.visited == false {
                verticesToVisit.append(endVertex)
                let totalDistance = currentVisitingVertex.distance + touchingHallway.length
                if totalDistance < endVertex.distance { endVertex.distance = totalDistance; endVertex.previousHallway = touchingHallway}
            }
        }
    }
    
    return nil /// if no shortest path found, return nothing
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

// MARK: - Custom Data Types
class Vertex: Equatable {
    let point: CGPoint
    var distance = CGFloat.infinity
    var touchingHallways = [DirectionalHallway]()
    
    var visited = false
    var previousHallway: DirectionalHallway?
    
    init(point: CGPoint) { self.point = point }
    static func == (l: Vertex, r: Vertex) -> Bool { return l === r }
}
struct DirectionalHallway {
    let start: CGPoint
    let end: CGPoint
    var length: CGFloat { DistanceFormula(from: start, to: end) } /// calculate length
}
struct Classroom: Identifiable, Hashable {
    var name: String
    var entrancePoints: [CGPoint] /// if PAC or CAF
    var entrancePoint: CGPoint /// normal classroom made of numbers (e.g. 403)
    
    init(name: String, entrancePoints: [CGPoint]) { self.name = name; self.entrancePoints = entrancePoints; self.entrancePoint = .zero } /// no need for `entrancePoint`
    init(name: String, entrancePoint: CGPoint) { self.name = name; self.entrancePoints = []; self.entrancePoint = entrancePoint } /// no need for `entrancePoints`
    
    let id = UUID() /// boilerplate protocol requirements
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
struct Route {
    var distance: CGFloat
    var path: [Vertex]
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
