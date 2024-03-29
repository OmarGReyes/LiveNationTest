//
//  EventDTO.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 17/03/24.
//

import Foundation

// MARK: - EventDTO
struct EventDTO: Codable {
    let name, id: String
    let images: [EventImage]
    let embedded: EventEmbedded?
    let dates: Dates?
    
    enum CodingKeys: String, CodingKey {
        case name, images, dates, id
        case embedded = "_embedded"
    }
}

// MARK: - EventDTO+Mapping
extension EventDTO {
    func toDomain() -> EventEntity {
        EventEntity(id: self.id,
                    name: self.name,
                    date: dates?.start?.localDate ?? "",
                    venue: self.embedded?.venues?.first?.name ?? "",
                    city: self.embedded?.venues?.first?.city?.name ?? "",
                    state: self.embedded?.venues?.first?.state?.stateCode ?? "",
                    imageURLString: self.images.first?.url ?? "noUrl"
        )
    }
}

// MARK: - Image
struct EventImage: Codable {
    let url: String?
    let width, height: Int?
    let fallback: Bool?
}

// MARK: - Dates
struct Dates: Codable {
    let start: Start?
    let timezone: String?
}

// MARK: - Start
struct Start: Codable {
    let localDate: String?
}

// MARK: - EventEmbedded
struct EventEmbedded: Codable {
    let venues: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
    let name: String?
    let city: City?
    let state: EventState?
}

// MARK: - City
struct City: Codable {
    let name: String?
}

// MARK: - State
struct EventState: Codable {
    let stateCode: String?
}
