//
//  PitchView.swift
//  MapWWDC
//
//  Created by MaToSens on 14/06/2023.
//

import SwiftUI
import MapKit

struct PitchView: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    
    var body: some View {
        Map(position: $position)
            .mapControls {
                
                /// Access to the 3D effect
                /// Zoom in on the map - HOLD OPTION
                MapPitchButton()
            }
    }
}

#Preview {
    PitchView()
}
