//
//  SearchRemoteDataManager.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

// MARK: - SearchRemoteDataManagerProtocol
protocol SearchRemoteDataManagerProtocol {
    func getEvents(term: String) async throws -> [EventDTO]
}

// MARK: - SearchRemoteDataManager
struct SearchRemoteDataManager: HTTPClient, SearchRemoteDataManagerProtocol {
    func getEvents(term: String) async throws -> [EventDTO] {
        let response = await sendRequest(endpoint: LiveNationEndpoint.search(term: term), responseModel: SearchResponseDTO.self)
        
        switch response {
        case .success(let success):
            return success.embedded.events
        case .failure(let failure):
            throw failure
        }
    }
}
