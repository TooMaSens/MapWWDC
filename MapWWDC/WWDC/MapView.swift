//
//  MapView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var position: MapCameraPosition = .camera(MapCamera(centerCoordinate: .parking, /// The map coordinate at the center of the map view.
                                                                       distance: 1980, /// The distance from the center point of the map to the
                                                                       heading: 90, /// The heading of the camera (in degrees) relative to true north.
                                                                       pitch: 60)) /// The viewing angle of the camera, in degrees.
    @State private var searchResults: [MKMapItem] = []
    var body: some View {
        Map(position: $position) {
            Annotation("Parking", coordinate: .parking) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondary, lineWidth: 5)
                    
                    Image(systemName: "car")
                        .padding(5)
                }
            }
            .annotationTitles(.hidden)
            
            
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
            
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                BeantownButtons(searchResults: $searchResults)
                    .padding(.top)
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: searchResults) {
            position = .automatic
        }
        
    }
}

#Preview {
    MapView()
}

extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 42.354528, longitude: -71.068369)
}

extension MKCoordinateSpan {
    static let span = MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
}


struct BeantownButtons: View {
    @Binding var searchResults: [MKMapItem]
    
    var body: some View {
        HStack {
            Button {
                search(for: "playground")
            } label: {
                Label("Playgrounds", systemImage: "figure.and.child.holdinghands")
            }
            .buttonStyle(.borderedProminent)
            
            
            Button {
                search(for: "beach")
            } label: {
                Label("Beaches", systemImage: "beach.umbrella")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
    }
    
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        
        request.region = MKCoordinateRegion(center: .parking, span: .span)
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            
            searchResults = response?.mapItems ?? []
        }
    }
}
