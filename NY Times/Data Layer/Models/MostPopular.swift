//
//  MostPopular.swift
//  NY Times
//
//  Created by Ahmed Osman on 20/02/2021.
//

import Foundation

struct Container<T: Codable>: Codable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let results: T?
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

struct MostPopular: Codable {
    let title: String?
    let abstract: String?
    let media: [Media]?
}

struct Media: Codable {
    var mediaMeta: [MediaMeta]
    
    enum CodingKeys: String, CodingKey {
        case mediaMeta = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaMeta = try container.decode([MediaMeta].self, forKey: .mediaMeta)
    }
}

struct MediaMeta: Codable {
    let url: String?
}
