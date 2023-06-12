//
//  HomeView.swift
//  MapWWDC
//
//  Created by MaToSens on 10/06/2023.
//

import SwiftUI
import MapKit
import SwiftData

@Observable
class HomeViewModel {
    var cameraPosition: MapCameraPosition = .region(.myRegion)
}

struct HomeView: View {
    @Bindable private var vm = HomeViewModel()
    
    var body: some View {
        Map(position: $vm.cameraPosition) {
        
            Marker("Map park", systemImage: "5.lane", coordinate: .myLocation)
        }
    }
}

#Preview {
    HomeView()
}



