//
//  LookView.swift
//  MapWWDC
//
//  Created by MaToSens on 14/06/2023.
//

import SwiftUI
import MapKit

struct LookView: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    
    // MARK: Selection Component
    @State private var mapSelection: MKMapItem?
    
    // MARK: Search Components
    @State private var searchText: String = ""
    @State private var searchResults: [MKMapItem] = []
    @State private var viewingRegion: MKCoordinateRegion?
    
    // MARK: Look Around Components
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var showDetails: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $position, selection: $mapSelection) {
                ForEach(searchResults, id: \.self) { option in
                    let title = option.placemark.title ?? "Place"
                    let coordinate = option.placemark.coordinate
                    
                    Marker(title, coordinate: coordinate)
                }
            }
            
            SearchBar(searchText: $searchText,
                      searchResults: $searchResults,
                      viewingRegion: $viewingRegion)
            
        }
        
        // MARK: Detail View
        .sheet(isPresented: $showDetails) {
            MapDetails()
                .presentationCornerRadius(50)
            ///  Use this modifier to change the corner radius of a presentation.
            
            
                .presentationDragIndicator(.visible)
            ///You can show a drag indicator when it isn’t apparent that a sheet can resize or when the sheet can’t dismiss interactively.
            
            
                .presentationDetents([.height(300), .large])
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
        
        .onChange(of: mapSelection) { oldValue, newValue in
            showDetails = (newValue != nil)
        }
        .onChange(of: mapSelection) {
            Task {
                do {
                    try await getLookAroundScene()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    LookView()
}

// MARK: View Components
extension LookView {
    
    @ViewBuilder
    func MapDetails() -> some View {
            if lookAroundScene == nil {
               contentUnavailableView
            } else {
                lookAroundPreview
            }
        
    }

    private var contentUnavailableView: some View {
        ContentUnavailableView("No Preview Available",
                               systemImage: "eye.slash",
                               description: Text("We will try to provide a preview in the future"))
    }
    
    private var lookAroundPreview: some View {
        VStack {
            Text("This is look around preview")
                .font(.title)
            
            LookAroundPreview(initialScene: lookAroundScene)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding([.top, .horizontal])
        }
    } 
}



// MARK: Function
extension LookView {
    
    private func getLookAroundScene() async throws {
        guard let mapSelection = mapSelection else { throw URLError(.badServerResponse) }
        
        let request = MKLookAroundSceneRequest(mapItem: mapSelection)
        lookAroundScene = try await request.scene
    }
    
}


