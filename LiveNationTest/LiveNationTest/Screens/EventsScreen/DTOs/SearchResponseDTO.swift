//
//  SearchResponse.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

struct SearchResponseDTO: Codable {
    let embedded: SearchResponseEmbeddedDTO
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct SearchResponseEmbeddedDTO: Codable {
    let events: [EventDTO]
}
