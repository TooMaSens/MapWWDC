////
////  Home.swift
////  Maps_iOS 17
////
////  Created by Balaji on 09/06/23.
////
//
//import SwiftUI
//import MapKit
//
//@MainActor
//class HomeViewModel: ObservableObject {
//    
//    @Published var searchResults: [MKMapItem] = []
//    @Published var searchText: String = ""
//    @Published var showSearch: Bool = false
//    
//}
//
//struct Home: View {
//    /// Map Properties
//    /// Use .userLocation(followsHeading: true, fallback: .region(.myRegion)), To follow the User in the Map
//    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
//    @State private var mapSelection: MKMapItem?
//    @Namespace private var locationSpace
//    @State private var viewingRegion: MKCoordinateRegion?
//    /// Search Properties
//    
//    @StateObject private var vm = HomeViewModel()
//    
//    
//    /// Map Selection Detail Properties
//    @State private var showDetails: Bool = false
//    @State private var lookAroundScene: MKLookAroundScene?
//    /// Route Properties
//    @State private var routeDisplaying: Bool = false
//    @State private var route: MKRoute?
//    @State private var routeDestination: MKMapItem?
//    var body: some View {
//        NavigationStack {
//            Map(position: $cameraPosition, selection: $mapSelection, scope: locationSpace) {
//                /// Map Annotations
//                Annotation("Apple Park", coordinate: .myLocation) {
//                    ZStack {
//                        Image(systemName: "applelogo")
//                            .font(.title3)
//                        
//                        Image(systemName: "square")
//                            .font(.largeTitle)
//                    }
//                }
//                .annotationTitles(.hidden)
//                
//                /// Simply Display Annotations as Marker, as we seen before
//                ForEach(vm.searchResults, id: \.self) { mapItem in
//                    /// Hiding All other Markers, Expect Destionation one
//                    if routeDisplaying {
//                        if mapItem == routeDestination {
//                            let placemark = mapItem.placemark
//                            Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
//                                .tint(.blue)
//                        }
//                    } else {
//                        let placemark = mapItem.placemark
//                        Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
//                            .tint(.blue)
//                    }
//                }
//                
//                /// Display Route using Polyline
//                if let route {
//                    MapPolyline(route.polyline)
//                    /// Applying Bigger Stroke
//                        .stroke(.blue, lineWidth: 7)
//                }
//                
//                /// To Show User Current Location
//                /// This will work only when the User Gave Location Access
//                UserAnnotation()
//            }
//            .onMapCameraChange({ ctx in
//                viewingRegion = ctx.region
//            })
//            .overlay(alignment: .bottomTrailing) {
//                VStack(spacing: 15) {
//                    MapCompass(scope: locationSpace)
//                    MapPitchButton(scope: locationSpace)
//                    /// As this will work only when the User Gave Location Access
//                    MapUserLocationButton(scope: locationSpace)
//                    /// This will Goes to the Defined User Region
//                    Button {
//                        withAnimation(.smooth) {
//                            cameraPosition = .region(.myRegion)
//                        }
//                    } label: {
//                        Image(systemName: "mappin")
//                            .font(.title3)
//                    }
//                    .buttonStyle(.borderedProminent)
//                }
//                .buttonBorderShape(.circle)
//                .padding()
//            }
//            .mapScope(locationSpace)
//            .navigationTitle("Map")
//            .navigationBarTitleDisplayMode(.inline)
//            /// Search Bar
//            .searchable(text: $vm.searchText, isPresented: $vm.showSearch)
//            /// Showing Trasnlucent ToolBar
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
//            /// When Route Displaying Hiding Top And Bottom Bar
//            .toolbar(routeDisplaying ? .hidden : .visible, for: .navigationBar)
//            .sheet(isPresented: $showDetails, onDismiss: {
//                withAnimation(.snappy) {
//                    /// Zooming Region
//                    if let boundingRect = route?.polyline.boundingMapRect, routeDisplaying {
//                        cameraPosition = .rect(boundingRect.reducedRect(0.45))
//                    }
//                }
//            }, content: {
//                MapDetails()
//                    .presentationDetents([.height(300)])
//                    .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
//                    .presentationCornerRadius(25)
//                    .interactiveDismissDisabled(true)
//            })
//            .safeAreaInset(edge: .bottom) {
//                if routeDisplaying {
//                    Button("End Route") {
//                        /// Closing The Route and Setting the Selection
//                        withAnimation(.snappy) {
//                            routeDisplaying = false
//                            showDetails = true
//                            mapSelection = routeDestination
//                            routeDestination = nil
//                            route = nil
//                            if let coordinate = mapSelection?.placemark.coordinate {
//                                cameraPosition = .region(.init(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000))
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .frame(maxWidth: .infinity)
//                    .contentShape(Rectangle())
//                    .padding(.vertical, 12)
//                    .background(.red.gradient, in: .rect(cornerRadius: 15))
//                    .padding()
//                    .background(.ultraThinMaterial)
//                }
//            }
//        }
//        .onSubmit(of: .search) {
//            Task {
//                guard !vm.searchText.isEmpty else { return }
//                
//                do {
//                    try await searchPlaces()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        .onChange(of: vm.showSearch, initial: false) {
//            if !vm.showSearch {
//                /// Clearing Search Results
//                vm.searchResults.removeAll(keepingCapacity: false)
//                showDetails = false
//                /// Zooming out to User Region when Search Cancelled
//                withAnimation(.smooth) {
//                    cameraPosition = .region(viewingRegion ?? .myRegion)
//                }
//            }
//        }
//        .onChange(of: mapSelection) { oldValue, newValue in
//            /// Displaying Details about the Selected Place
//            showDetails = newValue != nil
//            /// Fetching Look Around Preview, when ever selection Changes
//            Task {
//                do {
//                    try await fetchLookAroundPreview()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//            
//        }
//    }
//    
//    /// Map Details View
//    @ViewBuilder
//    func MapDetails() -> some View {
//        VStack(spacing: 15) {
//            ZStack {
//                /// New Look Around API
//                if lookAroundScene == nil {
//                    /// New Empty View API
//                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
//                } else {
//                    LookAroundPreview(scene: $lookAroundScene)
//                }
//            }
//            .frame(height: 200)
//            .clipShape(.rect(cornerRadius: 15))
//            /// Close Button
//            .overlay(alignment: .topTrailing) {
//                Button(action: {
//                    /// Closing View
//                    showDetails = false
//                    withAnimation(.snappy) {
//                        mapSelection = nil
//                    }
//                }, label: {
//                    Image(systemName: "xmark.circle.fill")
//                        .font(.title)
//                        .foregroundStyle(.black)
//                        .background(.white, in: .circle)
//                })
//                .padding(10)
//            }
//            
//            /// Direction's Button
//            Button("Get Directions", action: fetchRoute)
//                .foregroundStyle(.white)
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 12)
//                .contentShape(Rectangle())
//                .background(.blue.gradient, in: .rect(cornerRadius: 15))
//        }
//        .padding(15)
//    }
//    
//    /// Search Places
//    func searchPlaces() async throws {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = vm.searchText
//        request.region = viewingRegion ?? .myRegion
//        
//        let result = try await MKLocalSearch(request: request).start()
//        vm.searchResults = result.mapItems
//    }
//    
//    /// Fetching Location Preview
//    //    func fetchLookAroundPreview() {
//    //        if let mapSelection {
//    //            /// Clearing Old One
//    //            lookAroundScene = nil
//    //            Task.detached(priority: .background) {
//    //                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
//    //                lookAroundScene = try? await request.scene
//    //            }
//    //        }
//    //    }
//    
//    func fetchLookAroundPreview() async throws {
//        if let mapSelection {
//            let request = MKLookAroundSceneRequest(mapItem: mapSelection)
//            self.lookAroundScene = try await request.scene
//        }
//    }
//    
//    /// Fetching Route
//    func fetchRoute() {
//        if let mapSelection {
//            let request = MKDirections.Request()
//            request.source = .init(placemark: .init(coordinate: .myLocation))
//            request.destination = mapSelection
//            
//            Task {
//                let result = try? await MKDirections(request: request).calculate()
//                route = result?.routes.first
//                /// Saving Route Destination
//                routeDestination = mapSelection
//                
//                withAnimation(.snappy) {
//                    routeDisplaying = true
//                    showDetails = false
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
//
//extension MKMapRect {
//    func reducedRect(_ fraction: CGFloat = 0.35) -> MKMapRect {
//        var regionRect = self
//        
//        let wPadding = regionRect.size.width * fraction
//        let hPadding = regionRect.size.height * fraction
//        
//        regionRect.size.width += wPadding
//        regionRect.size.height += hPadding
//        
//        regionRect.origin.x -= wPadding / 2
//        regionRect.origin.y -= hPadding / 2
//        
//        return regionRect
//    }
//}
//
///// Location Data
//extension CLLocationCoordinate2D {
//    static var myLocation: CLLocationCoordinate2D {
//        return .init(latitude: 37.3346, longitude: -122.0090)
//    }
//}
//
//extension MKCoordinateRegion {
//    static var myRegion: MKCoordinateRegion {
//        return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
//    }
//}
