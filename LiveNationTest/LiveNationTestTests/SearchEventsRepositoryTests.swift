//
//  SearchEventsRepositoryTests.swift
//  LiveNationTestTests
//
//  Created by Omar Gonzalez on 17/03/24.
//

import XCTest
@testable import LiveNationTest

final class LiveNationRepositoryTests: XCTestCase {
    
    func test_searchRepositoryGetEvents_returnEventsArray() async {
        // Given
        let searchText = "Some text"
        let dataManager = SearchEventsRemoteDataManagerMock()
        let repository = SearchRepository(searchRemoteDataManager: dataManager)
        
        // When
        let events = try! await repository.getEvents(term: searchText)
        let event = events.first!
        
        // Then
        XCTAssertEqual(event.name, "Event 1")
        XCTAssertEqual(event.id, "1")
        XCTAssertEqual(event.location, "City 1, S1")
        XCTAssertEqual(event.venue, "Venue 1")
        XCTAssertEqual(event.formattedDate, "5 Jul 2024")
    }
    
    func tests_searchRepositoryGetEvents_throwError() async {
        // Given
        let searchText = "Some text"
        let dataManager = SearchEventsRemoteDataManagerMock(error: .networkingError)
        let repository = SearchRepository(searchRemoteDataManager: dataManager)
        var requestError: RequestError?
        
        // When
        do {
            let _ = try await repository.getEvents(term: searchText)
        } catch {
            requestError = error as? RequestError
        }
        
        // Then
        XCTAssertNotNil(requestError)
        XCTAssertEqual(requestError, .networkingError)
    }
}


fileprivate struct SearchEventsRemoteDataManagerMock: SearchRemoteDataManagerProtocol {
    let error: RequestError?
    
    init(error: RequestError? = nil) {
        self.error = error
    }
    
    func getEvents(term: String) async throws -> [EventDTO] {
        if let error = error {
            throw error
        }
        return [
            EventDTO(name: "Event 1",
                     id: "1",
                     images: [EventImage(url: "string1", width: 100, height: 100, fallback: true)],
                     embedded: EventEmbedded(venues: [Venue(
                        name: "Venue 1",
                        city: City(name: "City 1"),
                        state: EventState(stateCode: "S1")
                     )]),
                     dates: Dates(
                        start: Start(localDate: "2024-07-05"),
                        timezone: nil))
        ]
    }
}
