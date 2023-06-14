//
//  UserLocationView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit

// MARK: Description
/// Camera position that follows the user's location

/// - Parameters:
///   - followsHeading: If the camera should rotate to match the heading of the user.
///   - fallback: The position to use if the user's location hasn't yet been resolved.

/// - Parameters:
///   - centerCoordinate: The map coordinate at the center of the map view.
///   - distance: The distance from the center point of the map to the camera, in meters.
///   - heading: The heading of the camera (in degrees) relative to true north.
///   - pitch: The viewing angle of the camera, in degrees.

struct UserLocationView: View {
    @State private var position: MapCameraPosition = .userLocation(
        fallback: .camera(
            MapCamera(centerCoordinate: .parking,
                      distance: 1980,
                      heading: 90,
                      pitch: 60)
        )
    )
    
    // MARK: Initializes the class to get permission to access the location
    init() { _ = LocationPermissionManager() }
    
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            
            // MARK: WORK ONLY IF WE HAVE ACCESS TO THE USER'S LOCATION
            MapUserLocationButton()
            /// Changes the position of the camera to the user's location
        }
    }
}

#Preview {
    UserLocationView()
}
