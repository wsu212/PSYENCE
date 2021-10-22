//
//  MockService.swift
//  PSYENCETests
//
//  Created by Wei-Lun Su on 2021/10/22.
//

import Foundation
@testable import PSYENCE

final class MockService: ListServiceType {
    let endpoint: Endpoint = .staffpicks
    
    func getList(at page: Int, completion: @escaping ((List?, Error?) -> Void)) {
        completion(nil, nil)
    }
}
