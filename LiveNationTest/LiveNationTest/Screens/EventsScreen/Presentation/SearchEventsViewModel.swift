//
//  SearchEventsViewModel.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

final class SearchEventsViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchState: ViewState = .empty
    @Published var events = [EventEntity]()
    @Published var displayError = false
    @Published var errorMessage = ""
    
    // MARK: - Private variables
    private let searchRepository: SearchEventRepositoryProtocol
    
    init(searchRepository: SearchEventRepositoryProtocol) {
        self.searchRepository = searchRepository
    }
    
    @MainActor
    func fetchEvents() async {
        guard !searchText.isEmpty else { return }
        searchState = .loading
        events = await getEvents(term: searchText)
    }
    
    @MainActor
    private func getEvents(term: String) async -> [EventEntity] {
        do {
            let events = try await searchRepository.getEvents(term: term)
            searchState = .success
            return events
        } catch let error as RequestError {
            displayError = true
            errorMessage = error.customMessage
        } catch {
            displayError = true
            errorMessage = error.localizedDescription
        }
        searchState = .failure
        return []
    }
}
