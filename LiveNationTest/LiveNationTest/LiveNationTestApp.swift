//
//  LiveNationTestApp.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import SwiftUI

@main
struct LiveNationTestApp: App {
    
    let viewModel: SearchEventsViewModel
    
    init() {
        let searchRemoteDataManager = SearchRemoteDataManager()
        let searchRepository = SearchRepository(searchRemoteDataManager: searchRemoteDataManager)
        self.viewModel = SearchEventsViewModel(searchRepository: searchRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            SearchEventsScreen(viewModel: viewModel)
        }
    }
}
