//
//  CameraView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit

// MARK: Descriptions

/// - Parameters:
///   - centerCoordinate: The map coordinate at the center of the map view.
///   - distance: The distance from the center point of the map to the camera, in meters.
///   - heading: The heading of the camera (in degrees) relative to true north.
///   - pitch: The viewing angle of the camera, in degrees.


struct CameraView: View {
    @State private var position: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: .parking,
                  distance: 1980,
                  heading: 90,
                  pitch: 60)
    )
    
    var body: some View {
        Map(position: $position) {
            Marker("Parking", coordinate: .parking)
        }
    }
}

#Preview {
    CameraView()
}
