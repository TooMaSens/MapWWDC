//
//  CompasView.swift
//  MapWWDC
//
//  Created by MaToSens on 14/06/2023.
//

import SwiftUI
import MapKit

struct CompasView: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    
    var body: some View {
        Map(position: $position)
            .mapControls {
                
                /// To show map compass
                /// Rotate the map to see  - HOLD OPTION
                MapCompass()
            }
    }
}

#Preview {
    CompasView()
}
