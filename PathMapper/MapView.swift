//
//  MapView.swift
//  PathMapper
//
//  Created by Zheng on 3/26/21.
//

import SwiftUI

struct MapView: View {
    @State var points = [CGPoint]()
    
    var body: some View {
        Path { path in
            
            if !points.isEmpty {
                print("po \(points)_")
                
                path.move(to: points.first!)
                
                for point in points {
                    path.addLine(to: point)
                }
                
            }
        }
        .frame(width: 400, height: 400)
    }
    
    func drawWith(vertices: [Vertex]) {
        self.points = vertices.map { $0.point }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
