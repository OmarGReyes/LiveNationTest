//
//  EventEntity.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//
import Foundation

struct EventEntity {
    let id: String
    let name: String
    let date: String
    let venue: String
    let city: String
    let state: String
    let imageURLString: String
}

extension EventEntity {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatterYyyyMMDd
        let dateFormatted = dateFormatter.date(from: date)
        if let dateFormatted = dateFormatted {
            return dateFormatted.formatted(date: .abbreviated, time: .omitted)
        }
        return ""
    }
    
    var imageURL: URL {
        return URL(string: imageURLString)!
    }
    
    var location: String {
        if !city.isEmpty && !state.isEmpty {
            return city + ", " + state
        } else if !city.isEmpty && state.isEmpty {
            return city
        } else if city.isEmpty {
            return Constants.noLocationAvailable
        }
        return ""
    }
}
