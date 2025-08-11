//
//  MKPointAnnotation+Restaurant.swift
//  SeSAC-Assignment-32
//
//  Created by 김민성 on 8/11/25.
//

import MapKit

extension MKPointAnnotation {
    
    convenience init(from restaurant: Restaurant) {
        self.init()
        self.coordinate = CLLocationCoordinate2D(
            latitude: restaurant.latitude,
            longitude: restaurant.longitude
        )
        self.title = restaurant.name
        self.subtitle = restaurant.phoneNumber
    }
    
}
