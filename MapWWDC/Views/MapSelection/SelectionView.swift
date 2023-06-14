//
//  SelectionView.swift
//  MapWWDC
//
//  Created by MaToSens on 14/06/2023.
//

import SwiftUI
import MapKit
import ContactsUI

// MARK: Description

/// I'm receiving the selection as an MKMapItem, and because my search result are MKMapItems, consider that if
/// you have diffrent rypes of annotations with different types of data, then specify a unique tag for each annotation
/// and receive the selection based on tag type, just ike
/// PICKERS

struct SelectionView: View {
    @State private var position: MapCameraPosition = .region(.myRegion)
    
    @State private var mapSelection: MKMapItem?
    /// A map item includes a geographic location and any interesting data that might apply to that location,
    /// such as the address at that location and the name of a business at that address.
    /// You can also create a special MKMapItem object representing the user’s location
    /// LOOK AT 'ITEM 4'
    
    let selectionOption: [MKMapItem] = [.item1, .item2, .item3, .item4]
   
    var body: some View {
        Map(position: $position, selection: $mapSelection) {
            ForEach(selectionOption, id: \.self) { option in
                let title = option.placemark.title ?? "Point"
                let coordinate = option.placemark.coordinate
                
                Marker(title, coordinate: coordinate)
            }
        }
    }
}

#Preview {
    SelectionView()
}



extension MKMapItem {
    static var item1 = MKMapItem(placemark: .placemark1)
    static var item2 = MKMapItem(placemark: .placemark2)
    static var item3 = MKMapItem(placemark: .placemark3)
    
    // EXTRA
    static var item4 = MKMapItem(placemark: .placemark4)
}

extension MKPlacemark {
    static var placemark1 = MKPlacemark(coordinate: .coordinate1)
    static var placemark2 = MKPlacemark(coordinate: .coordinate2)
    static var placemark3 = MKPlacemark(coordinate: .coordinate3)
    
    // EXTRA
    static var placemark4: MKPlacemark {
        let address = [
            CNPostalAddressStreetKey: "24 Happy Street",
            CNPostalAddressCityKey: "Warsaw",
            CNPostalAddressPostalCodeKey: "01-393",
            CNPostalAddressISOCountryCodeKey: "PL"
        ]
        
        return MKPlacemark(coordinate: .coordinate4, addressDictionary: address)
    }
}

extension CLLocationCoordinate2D {
    static var coordinate1:  CLLocationCoordinate2D = .init(latitude: 52.24, longitude: 21.01)
    static var coordinate2: CLLocationCoordinate2D = .init(latitude: 52.25, longitude: 21.03)
    static var coordinate3: CLLocationCoordinate2D = .init(latitude: 52.23, longitude: 21.00)
    
    // EXTRA
    static var coordinate4: CLLocationCoordinate2D = .init(latitude: 52.24, longitude: 21.00)
}


