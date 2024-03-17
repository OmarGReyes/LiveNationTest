//
//  SearchEventsViewModelTests.swift
//  LiveNationTestTests
//
//  Created by Omar Gonzalez on 17/03/24.
//

import XCTest
@testable import LiveNationTest

final class SearchEventsViewModelTests: XCTestCase {
    func test_EventsListInitialState_empty() {
        // Given
        let repository = SearchRepositoryMock()
        
        // When
        let viewModel = SearchEventsViewModel(searchRepository: repository)
        
        // Then
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.searchState, .empty)
        XCTAssertTrue(viewModel.events.isEmpty)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }
    
    func test_fetchEvents_withOutSearchText_eventsArrayEmpty() async {
        // Given
        let searchText = ""
        let repository = SearchRepositoryMock()
        let viewModel = SearchEventsViewModel(searchRepository: repository)
        
        // When
        viewModel.searchText = searchText
        await viewModel.fetchEvents()
        
        // Then
        XCTAssertTrue(viewModel.events.isEmpty)
        XCTAssertEqual(viewModel.searchState, .empty)
    }
    
    func test_fetchEvents_withSearchText_eventsArrayWithValues() async {
        // Given
        let searchText = "some term"
        let repository = SearchRepositoryMock()
        let viewModel = SearchEventsViewModel(searchRepository: repository)
        
        // When
        viewModel.searchText = searchText
        await viewModel.fetchEvents()
        
        // Then
        XCTAssertFalse(viewModel.events.isEmpty)
        XCTAssertEqual(viewModel.events.count, 10)
        XCTAssertEqual(viewModel.searchState, .success)
    }
    
    func test_fetchEventsThrowingError_catchError() async {
        // Given
        let searchText = "some text"
        let repository = SearchRepositoryMock(error: .networkingError)
        let viewModel = SearchEventsViewModel(searchRepository: repository)
        
        // When
        viewModel.searchText = searchText
        await viewModel.fetchEvents()
        
        // Then
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
        XCTAssertTrue(viewModel.events.isEmpty)
        XCTAssertEqual(viewModel.searchState, .failure)
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, RequestError.networkingError.customMessage)
    }
}

// MARK: Mocked Events Array
extension SearchEventsViewModelTests {
    static var eventsMockArray: [EventEntity] = [
        EventEntity(id: "1", name: "Event 1", date: "2024-08-30", venue: "Venue 1", city: "City 1", state: "State 1", imageURLString: "image1.jpg"),
        EventEntity(id: "2", name: "Event 2", date: "2024-09-05", venue: "Venue 2", city: "City 2", state: "State 2", imageURLString: "image2.jpg"),
        EventEntity(id: "3", name: "Event 3", date: "2024-09-12", venue: "Venue 3", city: "City 3", state: "State 3", imageURLString: "image3.jpg"),
        EventEntity(id: "4", name: "Event 4", date: "2024-09-19", venue: "Venue 4", city: "City 4", state: "State 4", imageURLString: "image4.jpg"),
        EventEntity(id: "5", name: "Event 5", date: "2024-09-26", venue: "Venue 5", city: "City 5", state: "State 5", imageURLString: "image5.jpg"),
        EventEntity(id: "6", name: "Event 6", date: "2024-10-03", venue: "Venue 6", city: "City 6", state: "State 6", imageURLString: "image6.jpg"),
        EventEntity(id: "7", name: "Event 7", date: "2024-10-10", venue: "Venue 7", city: "City 7", state: "State 7", imageURLString: "image7.jpg"),
        EventEntity(id: "8", name: "Event 8", date: "2024-10-17", venue: "Venue 8", city: "City 8", state: "State 8", imageURLString: "image8.jpg"),
        EventEntity(id: "9", name: "Event 9", date: "2024-10-24", venue: "Venue 9", city: "City 9", state: "State 9", imageURLString: "image9.jpg"),
        EventEntity(id: "10", name: "Event 10", date: "2024-10-31", venue: "Venue 10", city: "City 10", state: "State 10", imageURLString: "image10.jpg")
    ]
}

// MARK: SearchRepositoryMock
fileprivate struct SearchRepositoryMock: SearchEventRepositoryProtocol {
    let error: RequestError?
    
    init(error: RequestError? = nil) {
        self.error = error
    }
    
    func getEvents(term: String) async throws -> [EventEntity] {
        if let error = error {
            throw error
        }
        return SearchEventsViewModelTests.eventsMockArray
    }
}
