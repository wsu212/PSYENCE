//
//  List.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import Foundation

protocol List: Decodable {
    var page: Int { get }
    var last: String? { get }
    var items: [Item] { get }
}

protocol Item {
    var name: String? { get }
    var description: String? { get }
    var imageURL: URL? { get }
    
    var user: Staff? { get }
}
