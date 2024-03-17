//
//  LiveNatioEndpoint.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

// MARK: MeLiEndpoint Enum
enum LiveNationEndpoint {
    case search(term: String)
}

// MARK: MeLiEndpoint Enum extension
extension LiveNationEndpoint: Endpoint {
    // MARK: - path
    var path: String {
        switch self {
        case .search:
            return "/discovery/v2/events.json"
        }
    }
    // MARK: - method
    var method: RequestMethod {
        switch self {
        case .search:
            return .get
        }
    }
    // MARK: - header
    var header: [String : String]? {
        switch self {
        case .search:
            return nil
        }
    }
    // MARK: - body
    var body: [String : String]? {
        switch self {
        case .search:
            return nil
        }
    }
    // MARK: - query
    var queryItems: [String : String]? {
        switch self {
        case .search(let term):
            return ["keyword": term,
                    "apikey": Constants.apiKey,
                    "size": Constants.sizeOfSearchResponse]
        }
    }
}


