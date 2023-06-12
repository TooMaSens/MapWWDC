//
//  MapControlsView.swift
//  MapWWDC
//
//  Created by MaToSens on 12/06/2023.
//

import SwiftUI
import MapKit

struct MapControlsView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    
    var body: some View {
        Map(position: $cameraPosition) {
            /// To show user current location
            UserAnnotation()
        }
        .mapControls {
            /// To show map compass
            /// Rotate the map to see
            MapCompass()
            
            /// To show user location button
            /// which allows you to show the user's current location
            MapUserLocationButton()
            
            
            /// Access to the 3D effect
            /// Zoom in on the map
            MapPitchButton()
            
            
            /// To show scale
            /// Zoom in/out on the map
            MapScaleView()
             
        }
    }
}

#Preview {
    MapControlsView()
}
