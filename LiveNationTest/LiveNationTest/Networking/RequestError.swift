//
//  RequestError.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

enum RequestError: String, Error {
    case decode = "Decode error"
    case invalidURL = "Invalid URL"
    case noResponse = "No response from server"
    case unauthorized = "Session expired"
    case unexpectedStatusCode = "Server error"
    case unknown = "Unknown error"
    case networkingError = "Networking error"
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .networkingError:
            return "Networking error, please check your connection"
        default:
            return "Unknown error"
        }
    }
}

