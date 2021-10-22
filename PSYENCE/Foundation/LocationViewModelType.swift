//
//  LocationViewModelType.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import CoreLocation
import Foundation

protocol LocationViewModelType {
    var didFindLocation: ((CLLocation, CLLocationDistance) -> Void)? { get set }
    var didAccessProfile: ((Author) -> Void)? { get set }
    func findLocation()
    func accessProfile()
}
