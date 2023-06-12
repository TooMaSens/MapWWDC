//
//  MapSearchView.swift
//  MapWWDC
//
//  Created by MaToSens on 12/06/2023.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                
                ForEach(searchResults, id: \.self) { mapItem in
                    let placemark = mapItem.placemark
                    
                    Marker(placemark.title ?? "Place", coordinate: placemark.coordinate)
                }
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, isPresented: $showSearch)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
          
        }
        .onSubmit(of: .search) {
            Task {
                do {
                    try await searchPlaces()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .onChange(of: showSearch) {
            if !showSearch {
                searchResults.removeAll()
            }
        }
    }
    
    
    func searchPlaces() async throws {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .myRegion
        
        let result = try await MKLocalSearch(request: request).start()
        searchResults = result.mapItems
    }
}

#Preview {
    MapSearchView()
}
