//
//  MapSelection.swift
//  MapWWDC
//
//  Created by MaToSens on 12/06/2023.
//

import SwiftUI
import MapKit

// MARK: Description

/// I'm receiving the selection as an MKMapItem, and because my search result are MKMapItems, consider that if
/// you have diffrent rypes of annotations with different types of data, then specify a unique tag for each annotation
/// and receive the selection based on tag type, just ike
/// PICKERS

struct MapSelection: View {
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    
    // MARK: Search
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResults: [MKMapItem] = []
    
    
    // MARK: Map Selection
    @State private var mapSelection: MKMapItem?
    /// A map item includes a geographic location and any interesting data that might apply to that location,
    /// such as the address at that location and the name of a business at that address.
    /// You can also create a special MKMapItem object representing the user’s location
 
    @State private var showDetails: Bool = false
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition, selection: $mapSelection) {
                
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
            
            // MARK: Detail View
            .sheet(isPresented: $showDetails) {
                MapDetails()
                    .presentationCornerRadius(50)
                ///  Use this modifier to change the corner radius of a presentation.
                
                
                    .presentationDragIndicator(.visible)
                ///You can show a drag indicator when it isn’t apparent that a sheet can resize or when the sheet can’t dismiss interactively.
                
                
                    .presentationDetents([.medium, .large])
                /// A set of supported detents for the sheet.
                /// If you provide more that one detent, people can drag the sheet to resize it.
                
                
                    .presentationBackgroundInteraction(.enabled)
                /// On many platforms, SwiftUI automatically disables the view behind a sheet that you present,
                /// so that people can’t interact with the backing view until they dismiss the sheet.
                /// Use this modifier if you want to enable interaction.
                
                
                    .interactiveDismissDisabled(true)
                /// You typically do this to prevent the user from dismissing a presentation before providing needed data
                /// or completing a required action
                    
            }
            
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
        
        // Detail View
        .onChange(of: mapSelection) { oldValue, newValue in
            showDetails = (newValue != nil)
        }
    }
    
    
    func MapDetails() -> some View {
        Text("Hello")
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
    MapSelection()
}


