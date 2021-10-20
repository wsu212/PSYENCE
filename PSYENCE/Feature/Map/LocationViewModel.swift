//
//  LocationViewModel.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import Foundation
import CoreLocation

final class LocationViewModel: LocationViewModelType {
    
    var didFindLocation: ((CLLocation, CLLocationDistance) -> Void)?
    
    private let locationDistance: CLLocationDistance = 1000
    
    private let user: Staff
        
    // MARK: - Initializer
    
    init(user: Staff) {
        self.user = user
    }
    
    func findLocation() {
        guard
            let latitude = user.locationDetails?.latitude,
            let longitude = user.locationDetails?.longitude else { return }
        let location = CLLocation(latitude: latitude, longitude: longitude)
        self.didFindLocation?(location, locationDistance)
    }
}
