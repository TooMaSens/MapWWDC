//
//  Selection2View.swift
//  MapWWDC
//
//  Created by MaToSens on 14/06/2023.
//

import SwiftUI
import MapKit


struct Selection2View: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    @State private var mapSelection: Int?
    
    
    // MARK: Important
    // With tag you can use any type conforming to hashable for you selection
    
//    @State private var mapSelection: String?
//    @State private var mapSelection: Int?
//    @State private var mapSelection: Conform to HASHABLE
    
    var body: some View {
        Map(position: $position, selection: $mapSelection) {
            Marker("Place 1", coordinate: .coordinate1)
                .tag(1)
//                .tag("Place_1")
            
            Marker("Place 2", coordinate: .coordinate2)
                .tag(2)
//                .tag("Place_2")
        }
    }
}

#Preview {
    Selection2View()
}
