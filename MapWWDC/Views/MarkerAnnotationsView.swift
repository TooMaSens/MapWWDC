//
//  MarkerAnnotations.swift
//  MapWWDC
//
//  Created by MaToSens on 10/06/2023.
//

import SwiftUI
import MapKit
import ContactsUI

// MARK: Description

/// We can annotate in map in tow ways:
/// 1. Marker - with a default balloon shape with custom icons in it,
/// 2. AnnotationView - witch will allow us to define our own SwiftUI View as an annotation view
/// 3. UserAnnotation - show user current location

struct MarkerAnnotationsView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    
    let coordinate: CLLocationCoordinate2D = .init(latitude: 52.24, longitude: 21.01)
    let coordinate2: CLLocationCoordinate2D = .init(latitude: 52.25, longitude: 21.03)
    let coordinate3: CLLocationCoordinate2D = .init(latitude: 52.26, longitude: 21.03)
    
    var body: some View {
        Map(position: $cameraPosition) {
            // MARK: Map Annotations - Marker
            Group {
                Marker(item: getMKMapItem())
                    .tint(.blue) /// Change the color of the marker
                
                
                Marker("Marker", coordinate: coordinate)
                    .annotationTitles(.hidden) /// Change the visibility of the title
                
                
                Marker("Marker with systemImage", systemImage: "house", coordinate: coordinate2)
                    .annotationSubtitles(.automatic)

                
                Marker("Marker with Image", image: "carImage", coordinate: coordinate3)
            }
    
            
            // MARK: Map annotations - Annotations
//            Group {
//                Annotation("Home", coordinate: coordinate) {
//                    ZStack {
//                        Image(systemName: "house")
//                            .foregroundStyle(.red)
//                            .font(.footnote)
//                            .padding(5)
//                            .overlay(alignment: .bottom) {
//                                RoundedRectangle(cornerRadius: 5, style: .continuous)
//                                    .stroke(lineWidth: 1)
//                                    .frame(height: 1)
//                            }
//                    }
//                }
//                
//                
//                Annotation("Second home", coordinate: coordinate2, anchor: .bottom) {
//                    Text("Here")
//                        .background(Color.blue)
//                        .font(.largeTitle)
//                        .foregroundStyle(.yellow)
//                }
//                .stroke(Color.red, lineWidth: 3)
//                
//            }
            
            
            // MARK: Map annotations - User
            UserAnnotation()
            
        }
    }
    
    // MARK: Item - MKMapItem
    func getMKMapItem() -> MKMapItem {
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.23, longitude: 21.0)
        let address = [
            CNPostalAddressStreetKey: "24 Happy Street, Warsaw",
            CNPostalAddressCityKey: "Warsaw",
            CNPostalAddressPostalCodeKey: "01-393",
            CNPostalAddressISOCountryCodeKey: "PL"
        ]
        let placemark: MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: address)
        let item: MKMapItem = MKMapItem(placemark: placemark)
        
        return item
    }
}

#Preview {
    MarkerAnnotationsView()
}






