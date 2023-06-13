//
//  AutomaticView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit

// MARK: Description
/// By default we have .automatic

/// - Parameters:
///   - automatic: The map coordinate at the center of the map view. Create a position that frames the map's content.


struct AutomaticView: View {
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
//        Map(position: $position) {
//            Marker("Parking", coordinate: .parking)
//        }
        
        Map() {
            Marker("Parking", coordinate: .parking)
        }
    }
}

#Preview {
    AutomaticView()
}
