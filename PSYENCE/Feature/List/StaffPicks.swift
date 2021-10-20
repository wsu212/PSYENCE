//
//  StaffPicks.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import Foundation

struct StaffPicks: Decodable {
    var totalCount: Int
    var page: Int
    var batchSize: Int
    var paging: Paging
    var videos: [Video]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total"
        case page = "page"
        case batchSize = "per_page"
        case paging = "paging"
        case videos = "data"
    }
}

struct Paging: Decodable {
    var next: String?
    var previous: String?
    var first: String?
    var last: String?
}

struct Video: Decodable {
    var uri: String?
    var name: String?
    var description: String?
    var link: String?
    var duration: Int?
    var width: Int?
    var language: String?
    var height: Int?
    var user: Staff?
    var pictures: Pictures?
}

struct Staff: Decodable {
    var uri: String?
    var name: String?
    var link: String?
    var location: String?
    var bio: String?
    var pictures: Pictures?
    var locationDetails: LocationDetails?
    
    enum CodingKeys: String, CodingKey {
        case uri
        case name
        case link
        case location
        case bio
        case pictures
        case locationDetails = "location_details"
    }
}

struct LocationDetails: Decodable {
    var latitude: Double?
    var longitude: Double?
    var city: String?
    var state: String?
}

struct Pictures: Decodable {
    var uri: String?
    var active: Bool?
    var type: String?
    var sizes: [PictureSize]?
}

struct PictureSize: Decodable {
    var width: Int?
    var height: Int?
    var link: String?
}

// MARK: - Extensions

extension Video: Item {
    var imageURL: URL? {
        guard let urlString = self.pictures?.sizes?.last?.link else { return nil }
        return .init(string: urlString)
    }
}

extension StaffPicks: List {
    var last: String? {
        paging.last
    }
    
    var items: [Item] {
        videos
    }
}
