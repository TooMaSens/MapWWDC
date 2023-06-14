//
//  ItemView.swift
//  MapWWDC
//
//  Created by MaToSens on 13/06/2023.
//

import SwiftUI
import MapKit
import ContactsUI

struct ItemView: View {
    @State private var position: MapCameraPosition = .item(.warsaw)
    
    var body: some View {
        Map(position: $position)
    }
}

#Preview {
    ItemView()
}

extension MKMapItem {

    static var warsaw: MKMapItem {
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.23, longitude: 21.0)
        
        /// import ContactsUI
        /// Allows us to create an adress
        let address = [
            CNPostalAddressStreetKey: "24 Happy Street",
            CNPostalAddressCityKey: "Warsaw",
            CNPostalAddressPostalCodeKey: "01-393",
            CNPostalAddressISOCountryCodeKey: "PL"
        ]
        
        //
        let placemark: MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: address)
        
        return MKMapItem(placemark: placemark)
    }
}
