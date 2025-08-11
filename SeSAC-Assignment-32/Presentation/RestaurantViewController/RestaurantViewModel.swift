//
//  RestaurantViewModel.swift
//  SeSAC-Assignment-32
//
//  Created by 김민성 on 8/11/25.
//

import MapKit

final class RestaurantViewModel {
    
    // MARK: - Input
    let categorySelectInput = MSSubject<RestaurantCategory>(value: .all)
    
    // MARK: - Output
    let annotationsOutput = MSSubject<[MKPointAnnotation]>(value: [])
    
    init () {
        categorySelectInput.subscribe { [weak self] category in
            let annotations = RestaurantList.restaurantArray
                .filter { ($0.category == category.rawValue) || (category == .all) }
                .map { MKPointAnnotation(from: $0) }
            self?.annotationsOutput.value = annotations
        }
    }
    
}
