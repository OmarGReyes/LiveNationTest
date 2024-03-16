//
//  SearchResponse.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

struct SearchResponse: Codable {
    let events: [EventDTO]
    
    enum CodingKeys: String, CodingKey {
        case events = "_embedded"
    }
}

struct EventDTO: Codable {
    let name: String
    let images: [Image]
    let embedded: EventEmbedded?
    
    enum CodingKeys: String, CodingKey {
        case name, images
        case embedded = "_embedded"
    }
}

// MARK: - Image
struct Image: Codable {
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
    let dateTBD, dateTBA, timeTBA, noSpecificTime: Bool?
}

// MARK: - EventEmbedded
struct EventEmbedded: Codable {
    let venues: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
    let name: String?
    let city: City?
    let state: State?
}

// MARK: - City
struct City: Codable {
    let name: String?
}

// MARK: - State
struct State: Codable {
    let name, stateCode: String?
}
