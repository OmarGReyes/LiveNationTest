//
//  Endpoint.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

// MARK: - Endpoint Protocol
protocol Endpoint {
    // MARK: Properties
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [String: String]? { get }
}

// MARK: - Endpoint Extension
extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return Constants.ticketMasterHost
    }
}
