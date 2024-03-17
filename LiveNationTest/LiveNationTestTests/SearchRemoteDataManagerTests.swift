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
        XCTAssertEqual(event.name, "Event 1")
        XCTAssertEqual(event.id, "1")
        XCTAssertTrue(event.images.isEmpty)
    }
}

fileprivate struct SearchRemoteDataManagerMock: HTTPClient, SearchRemoteDataManagerProtocol {
    func getEvents(term: String) async throws -> [EventDTO] {
        let response = await sendRequest(endpoint: LiveNationEndpoint.search(term: term), responseModel: SearchResponseDTO.self)
        
        switch response {
        case .success(let success):
            return success.embedded.events
        case .failure(let failure):
            throw failure
        }
    }
    
    func sendRequest<T>(endpoint: Endpoint,
                        responseModel: T.Type) async -> Result<T, RequestError> {
        let searchEmbeddedMock = SearchResponseEmbeddedDTO(events: [
            EventDTO(name: "Event 1",
                     id: "1",
                     images: [],
                     embedded: nil,
                     dates: nil)
        ])
        
        let responseMockModel = SearchResponseDTO(embedded: searchEmbeddedMock)
        return .success(responseMockModel as! T)
    }
}
