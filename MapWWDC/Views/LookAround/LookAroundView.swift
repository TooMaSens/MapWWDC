////
////  LookAroundView.swift
////  MapWWDC
////
////  Created by MaToSens on 12/06/2023.
////
//
//import SwiftUI
//import MapKit
//
//
//struct LookAroundView: View {
//    @StateObject private var vm = LookAroundViewModel()
//    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
//    
//    var body: some View {
//        NavigationStack {
//            Map(position: $cameraPosition, selection: $vm.mapSelection) {
//                
//                ForEach(vm.searchResults, id: \.self) { mapItem in
//                    let placemark = mapItem.placemark
//                    
//                    Marker(placemark.title ?? "Place", coordinate: placemark.coordinate)
//                }
//            }
//            .searchBarModifier()
//            .onMapCameraChange(frequency: .onEnd) {
//                vm.viewingRegion = $0.region
//            }
//            .overlay(alignment: .bottomTrailing)  {
//                Button {
//                    withAnimation(.smooth) {
//                        cameraPosition = .region(.myRegion)
//                    }
//                } label: {
//                    Image(systemName: "mappin")
//                        .font(.title3)
//                }
//                .buttonStyle(.borderedProminent)
//            }
//            
//            // MARK: Detail View
//            .sheet(isPresented: $vm.showDetails) {
//                MapDetails()
//                    .presentationCornerRadius(50)
//                    .presentationDragIndicator(.visible)
//                    .presentationDetents([.height(300)])
//                    .presentationBackgroundInteraction(.enabled)
//                    .interactiveDismissDisabled(true)
//            }
//            
//        }
//        .environmentObject(vm)
//        
//        // MARK: Search Components
//        .onSubmit(of: .search) {
//            vm.searchResults = []
//            Task {
//                do {
//                    try await searchPlaces()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        .onChange(of: vm.showSearch, initial: false) {
//            if !vm.showSearch {
//                vm.searchResults.removeAll()
//                vm.showDetails = false
//                
//                withAnimation(.smooth) {
//                    cameraPosition = .region(.myRegion)
//                }
//            }
//        }
//        
//        // MARK: Detail View Components
//        .onChange(of: vm.mapSelection) { oldValue, newValue in
//            /// Displaying Details about the Selected Place
//            vm.showDetails = (newValue != nil)
//            
//            /// Fetchin Look Around Preview, when ever selection Changes
//            Task {
//                do {
//                    try await fetchLookAroundPreview()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        
//        
//        
//        
//    }
//}
//
//#Preview {
//    LookAroundView()
//}
//
//
//// MARK: View Components
//extension LookAroundView {
//    
//    func MapDetails() -> some View {
//        VStack(spacing: 15) {
//            ZStack {
//                if vm.lookAroundScene == nil {
//                    ContentUnavailableView("No Preview Available",
//                                           systemImage: "eye.slash",
//                                           description: Text("We will try to provide a preview in the future"))
//                } else {
//                    LookAroundPreview(scene: $vm.lookAroundScene,
//                                      allowsNavigation: true,
//                                      showsRoadLabels: true)
//                }
//            }
//            .frame(height: 150)
//            .clipShape(.rect(cornerRadius: 15))
//            
//        }
//        .padding()
//        
//    }
//}
//
//
//// MARK: Functions
//extension LookAroundView {
//    func searchPlaces() async throws {
//        guard let region = vm.viewingRegion else { throw URLError(.badServerResponse) }
//        
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = vm.searchText
//        request.region = region
//        
//        let result = try await MKLocalSearch(request: request).start()
//        vm.searchResults = result.mapItems
//    }
//    
//    func fetchLookAroundPreview() async throws {
//        guard let mapSelection = vm.mapSelection else { return }
//        
//        let request = MKLookAroundSceneRequest(mapItem: mapSelection)
//        self.vm.lookAroundScene = try await request.scene
//    }
//    
//}
