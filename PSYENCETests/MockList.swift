//
//  MockList.swift
//  PSYENCETests
//
//  Created by Wei-Lun Su on 2021/10/22.
//

import Foundation
@testable import PSYENCE

struct MockList: List, Decodable {
    let page: Int
    let last: String?
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case page
        case last
        case items
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        last = try values.decode(String.self, forKey: .last)
        items = try values.decode([MockItem].self, forKey: .items)
    }
    
    init(page: Int, last: String?, items: [Item]) {
        self.page = page
        self.last = last
        self.items = items
    }
}

extension MockList {
    static func generateMockItems(_ count: Int) -> [MockItem] {
        return (0 ..< count)
            .map { MockItem(name: "Title \($0)", description: "Description \($0)", imageURL: nil, profile: nil, isValid: true) }
    }
}
