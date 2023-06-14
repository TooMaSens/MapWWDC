//
//  MapWWDCApp.swift
//  MapWWDC
//
//  Created by MaToSens on 10/06/2023.
//

import SwiftUI

@main
struct MapWWDCApp: App {
    init() { _ = LocationPermissionManager() }
    var body: some Scene {
        WindowGroup {
            LookView()
        }
    }
}
