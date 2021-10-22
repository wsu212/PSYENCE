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
    var didAccessProfile: ((Profile) -> Void)?
        
    private let locationDistance: CLLocationDistance = 1000
    
    private let item: Item
        
    // MARK: - Initializer
    
    init(item: Item) {
        self.item = item
    }
    
    func findLocation() {
        guard
            let latitude = item.profile?.latitude,
            let longitude = item.profile?.longitude else { return }
        let location = CLLocation(latitude: latitude, longitude: longitude)
        self.didFindLocation?(location, locationDistance)
    }
    
    func accessProfile() {
        if let profile = item.profile {
            self.didAccessProfile?(profile)
        }
    }
}
