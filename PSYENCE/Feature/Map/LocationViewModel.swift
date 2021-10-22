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
    var didAccessProfile: ((Author) -> Void)?
        
    private let locationDistance: CLLocationDistance = 1000
    
    private let author: Author
        
    // MARK: - Initializer
    
    init(author: Author) {
        self.author = author
    }
    
    func findLocation() {
        guard
            let latitude = author.locationDetails?.latitude,
            let longitude = author.locationDetails?.longitude else { return }
        let location = CLLocation(latitude: latitude, longitude: longitude)
        self.didFindLocation?(location, locationDistance)
    }
    
    func accessProfile() {
        self.didAccessProfile?(author)
    }
}
