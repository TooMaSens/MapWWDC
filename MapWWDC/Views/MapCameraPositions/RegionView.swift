//
//  RegionView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit

// MARK: Description
/// You use the delta values in this structure to indicate the desired zoom level of the map,
/// with smaller delta values corresponding to a higher zoom level

/// - Parameters:
///   - latitudeDelta: Indicate the desired zoom level of the map
///   - longitudeDelta: Indicate the desired zoom level of the map.


struct RegionView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(center: .applePark, span: .sampleSpan)
    )
    
    var body: some View {
        Map(position: $position) { }
    }
}

#Preview {
    RegionView()
}

extension CLLocationCoordinate2D {
    static var applePark = CLLocationCoordinate2D(latitude: 37.3347, longitude: -122.009)
}

extension MKCoordinateSpan {
    static var sampleSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

