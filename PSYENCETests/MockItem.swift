//
//  MockItem.swift
//  PSYENCETests
//
//  Created by Wei-Lun Su on 2021/10/22.
//

import Foundation
@testable import PSYENCE

struct MockItem: Item, Decodable {
    let name: String?
    let description: String?
    let imageURL: URL?
    let profile: Profile?
    let isValid: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case imageURL
        case profile
        case isValid
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageURL = try values.decodeIfPresent(URL.self, forKey: .imageURL)
        profile = try values.decodeIfPresent(MockProfile.self, forKey: .profile)
        isValid = try values.decode(Bool.self, forKey: .isValid)
    }
    
    init(
        name: String?,
        description: String?,
        imageURL: URL?,
        profile: Profile?,
        isValid: Bool
    ) {
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.profile = profile
        self.isValid = isValid
    }
}

struct MockProfile: Profile, Decodable {
    let imageURL: URL?
    let name: String?
    let bio: String?
    let latitude: Double?
    let longitude: Double?
    let isValid: Bool
}
