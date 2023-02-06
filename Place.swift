//
//  Place.swift
//  MapRoutes
//
//  Created by Marceles Moore on 2/6/23.
//

import SwiftUI
import MapKit
import CoreLocation
struct Place: Identifiable {
    
    var id = UUID().uuidString
    var place: CLPlacemark
}
