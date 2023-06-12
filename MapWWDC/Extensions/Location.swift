//
//  Location.swift
//  MapWWDC
//
//  Created by MaToSens on 10/06/2023.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D = .init(latitude: 52.237, longitude: 21.017)
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion = .init(center: .myLocation, span: .mySpan)
}

extension MKCoordinateSpan {
    static var mySpan: MKCoordinateSpan = .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

