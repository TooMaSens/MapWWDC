//
//  MarkerView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit

// MARK: Description
/// Marker - with a default balloon shape with custom icons in it,

struct MarkerView: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    
    let coordinate: CLLocationCoordinate2D = .init(latitude: 52.24, longitude: 21.01)
    let coordinate2: CLLocationCoordinate2D = .init(latitude: 52.25, longitude: 21.03)
    let coordinate3: CLLocationCoordinate2D = .init(latitude: 52.26, longitude: 21.03)
    
    var body: some View {
        Map(position: $position) {
            Marker(item: .warsaw)
                .tint(.blue) /// Change the color of the marker
            
            
            Marker("Marker", coordinate: coordinate)
                .tint(.brown)
                .annotationTitles(.hidden) /// Change the visibility of the title
            
            
            Marker("Marker with systemImage", systemImage: "house", coordinate: coordinate2)
                .tint(.cyan)
                .annotationSubtitles(.automatic) /// Change the visibility of the subtitle

            
            Marker("Marker with Image", image: "carImage", coordinate: coordinate3)
        }
    }
}

#Preview {
    MarkerView()
}


