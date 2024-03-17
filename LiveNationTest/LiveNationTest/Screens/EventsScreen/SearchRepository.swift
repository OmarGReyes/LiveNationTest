//
//  SearchRepository.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

protocol SearchEventRepositoryProtocol {
    func getEvents(term: String) async throws -> [EventEntity]
}

struct SearchRepository: SearchEventRepositoryProtocol {
    let searchRemoteDataManager: SearchRemoteDataManagerProtocol
    
    init(searchRemoteDataManager: SearchRemoteDataManagerProtocol) {
        self.searchRemoteDataManager = searchRemoteDataManager
    }
    
    func getEvents(term: String) async throws -> [EventEntity] {
        try await searchRemoteDataManager.getEvents(term: term).compactMap { $0.toDomain() }
    }
}
