////
////  LookAroundViewModel.swift
////  MapWWDC
////
////  Created by MaToSens on 12/06/2023.
////
//
//import Foundation
//import MapKit
//import SwiftData
//import _MapKit_SwiftUI
//
//@MainActor
//class LookAroundViewModel: ObservableObject {
//    // MARK: Camera Position - Region
////    @Published var cameraPosition: MapCameraPosition = .region(.myRegion)
//    
//    // MARK: Search
//    @Published var searchText: String = ""
//    @Published var showSearch: Bool = false
//    @Published var searchResults: [MKMapItem] = []
//    
//    
//    // MARK: Map Selection
//    @Published var mapSelection: MKMapItem? = nil
//    @Published var showDetails: Bool = false
//    
//    
//    // MARK: Look Around
//    @Published var lookAroundScene: MKLookAroundScene? = nil
//    @Published var viewingRegion: MKCoordinateRegion?
//    
//}
//
//// MARK: Functions
////extension LookAroundViewModel {
////    
////    func searchPlaces() async throws {
////        let request = MKLocalSearch.Request()
////        request.naturalLanguageQuery = searchText
////        request.region = viewingRegion ?? .myRegion
////
////        let result = try await MKLocalSearch(request: request).start()
////        searchResults = result.mapItems
////    }
////    
////    func fetchLookAroundPreview() async throws {
////        guard let mapSelection = mapSelection else { return }
////        
////        let request = MKLookAroundSceneRequest(mapItem: mapSelection)
////        self.lookAroundScene = try await request.scene
////    }
////}
