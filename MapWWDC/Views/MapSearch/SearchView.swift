//
//  SearchView.swift
//  MapWWDC
//
//  Created by MaToSens on 14/06/2023.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    
    // MARK: Allows to search where the camera is
    // Look in func searchPlaces() at the bottom of the page
    @State private var viewingRegion: MKCoordinateRegion?
    
    // MARK: Search Components
    @State private var searchText: String = ""
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $position) {
                ForEach(searchResults, id: \.self) { place in
                    let title = place.placemark.title ?? "Place"
                    let coordinate = place.placemark.coordinate
                    
                    Marker(title, coordinate: coordinate)
                }
            }
            
            searchBar()
        }
        .onMapCameraChange {
            viewingRegion = $0.region
        }
        
    }
}

#Preview {
    SearchView()
}


// MARK: View Components
extension SearchView {
    
    private func searchBar() -> some View {
        TextField("Search place", text: $searchText)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10, style: .continuous))
            .overlay(alignment: .trailing) { xmarkButton() }
            .padding()
            .onSubmit {
                Task {
                    do {
                        try await searchPlaces()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
           
    }
    
    private func xmarkButton() -> some View {
        Button {
            searchText = ""
            searchResults.removeAll()
        } label: {
            Image(systemName: "xmark")
                .padding(.trailing)
                .opacity(searchText.isEmpty ? 0 : 1)
        }
    }
}

// MARK: Funcion
extension SearchView {
    
    /// - Parameters:
    ///   - naturalLanguageQuery: A string containing the desired search item.
    ///   - region: A map region that provides a hint as to where to search.
    ///   - resultTypes: The types of items to include in the search results.
            /// - adress: A value that indicates that search results include addresses.
            /// - pointOfInterest: A value that indicates that search results include points of interest.
    ///   - pointOfInterestFilter : A filter that lists point-of-interest categories to include or exclude in search results.
    
    private func searchPlaces() async throws {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        // MARK: IMPORTANT
        // Setting the region to fixed coordinates will cause that even
        // after changing the location, the search will only occur
        // in the same place where we have set coordinates
        
//        request.region = .myRegion
        
        // To avoid this ->
        request.region = viewingRegion ?? .myRegion
        // If the camera has not changed its location, it will search in our region(.myRegion)
        
        let result = try await MKLocalSearch(request: request).start()
        searchResults = result.mapItems
    }
    
}
