//
//  ScaleView.swift
//  MapWWDC
//
//  Created by MaToSens on 14/06/2023.
//

import SwiftUI
import MapKit

struct ScaleView: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    
    var body: some View {
        Map(position: $position)
            .mapControls {
                
                /// To show scale
                /// Zoom in/out on the map - HOLD OPTION
                MapScaleView()
            }
    }
}

#Preview {
    ScaleView()
}
