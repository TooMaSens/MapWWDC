//
//  AnnotationView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit

// MARK: Description
/// Annotation - witch will allow us to define our own SwiftUI View as an annotation view

struct AnnotationView: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    
    let coordinate: CLLocationCoordinate2D = .init(latitude: 52.24, longitude: 21.01)
    let coordinate2: CLLocationCoordinate2D = .init(latitude: 52.25, longitude: 21.03)
    let coordinate3: CLLocationCoordinate2D = .init(latitude: 52.23, longitude: 21.00)
    
    var body: some View {
        Map(position: $position) {
            
            Annotation("Home", coordinate: coordinate) {
                Image(systemName: "house")
                    .font(.title)
                    .foregroundStyle(.red)
            }
            
            
            Annotation("Second home", coordinate: coordinate2, anchor: .bottom) {
                Text("Here")
                    .background(Color.blue)
                    .foregroundStyle(.yellow)
            }
            
            
            Annotation(coordinate: coordinate3) {
                Image(systemName: "mappin.circle")
                    .font(.title)
                    .foregroundStyle(.blue)
            } label: {
                Text("Third home")
            }
            
        }
    }
}

#Preview {
    AnnotationView()
}
