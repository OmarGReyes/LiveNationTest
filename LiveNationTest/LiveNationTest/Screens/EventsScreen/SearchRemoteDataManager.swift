//
//  SearchRemoteDataManager.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

protocol SearchRemoteDataManagerProtocol {
    func getEvents(term: String) async throws -> [EventDTO]
}

struct SearchRemoteDataManager: HTTPClient, SearchRemoteDataManagerProtocol {
    func getEvents(term: String) async throws -> [EventDTO] {
        let response = await sendRequest(endpoint: LiveNationEndpoint.search(term: term), responseModel: SearchResponse.self)
        
        switch response {
        case .success(let success):
            return success.embedded.events
        case .failure(let failure):
            throw failure
        }
    }
}
