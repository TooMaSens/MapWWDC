//
//  UserView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit

// MARK: Description
/// UserAnnotation - show user current location

/// Run simulator ->  Allow location access ->  In menu bar: 'Features' -> Location -> Custom Location:
/// Latitude:        52,237
/// Longitude:     21,017


/// Creates a position that frames the user's location.
///
/// - Parameters:
///   - followsHeading: If the camera should rotate to match the heading.
///     of the user.
///   - fallback: The position to use if the user's location hasn't yet been
///     resolved.

struct UserView: View {
    @State private var position: MapCameraPosition = .userLocation(
        followsHeading: false,
        fallback: .camera(
            MapCamera(centerCoordinate: .parking,
                      distance: 1980,
                      heading: 90,
                      pitch: 60)
        )
    )
    
    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
    }
}

#Preview {
    UserView()
}
