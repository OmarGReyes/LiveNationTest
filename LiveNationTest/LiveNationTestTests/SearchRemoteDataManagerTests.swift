//
//  SearchRemoteDataManagerTests.swift
//  LiveNationTestTests
//
//  Created by Omar Gonzalez on 17/03/24.
//

import XCTest
@testable import LiveNationTest

final class SearchRemoteDataManagerTests: XCTestCase {
    func test_getEvents_returnEvents() async {
        // Given
        let term = "any term"
        let remoteDataManagerMock = SearchRemoteDataManagerMock()
        
        // When
        let events = try! await remoteDataManagerMock.getEvents(term: term)
        let event = events.first!
        
        // Then
        XCTAssertEqual(event.name, "James Taylor")
        XCTAssertEqual(event.id, "vv1AeZkv6GkdHfkJ4")
        XCTAssertFalse(event.images.isEmpty)
    }
}

fileprivate class SearchRemoteDataManagerMock: SearchRemoteDataManagerProtocol, Mockable {
    func getEvents(term: String) async throws -> [EventDTO] {
        let response = await getSearchResponse()
        
        switch response {
        case .success(let success):
            return success.embedded.events
        case .failure(let failure):
            throw failure
        }
    }
    
    func getSearchResponse() async -> Result<SearchResponseDTO, RequestError> {
        return .success(loadJSON(filename: "response", type: SearchResponseDTO.self))
    }
}
