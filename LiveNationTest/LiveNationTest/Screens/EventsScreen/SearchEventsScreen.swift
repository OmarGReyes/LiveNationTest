//
//  SearchEventsView.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import SwiftUI

struct SearchEventsScreen: View {
    // MARK: - ViewModel
    @StateObject var viewModel: SearchEventsViewModel
    var body: some View {
        VStack(spacing: Constants.searchEventsScreenVStackSpacing) {
            titleView
            customSearchBar
            switch viewModel.searchState {
            case .success:
                eventListView
            case .failure:
                emptyView
            case .loading:
                progressView
            case .empty:
                emptyView
            }
        }
        .alert(Constants.searchEventsScreenErrorTitle, isPresented: $viewModel.displayError) {
            // TODO: Add action if needed
        } message: {
            Text(viewModel.errorMessage)
        }

    }
}

// MARK: Views
extension SearchEventsScreen {
    // MARK: - Custom SearchBar
    private var customSearchBar: some View {
        CustomSearchBar(searchText: $viewModel.searchText) {
            Task {
                await viewModel.fetchEvents()
            }
        } onTapXButton: {
            viewModel.searchText = ""
        }
    }
    
    // MARK: - progressView
    private var progressView: some View {
        LargeProgressView()
    }
    
    // MARK: - emptyView
    private var emptyView: some View {
        VStack {
            EmptyView()
            Spacer()
        }
    }
    
    // MARK: - eventListView
    private var eventListView: some View {
        List(viewModel.events, id: \.id) { event in
            EventListView(event: event)
                .listRowSeparator(.visible)
        }.onTapGesture {
            hideKeyboard()
        }
    }
    
    // MARK: - titleView
    private var titleView: some View {
        HStack(alignment: .center, content: {
            Text(Constants.searchEventsScreenTitle)
                .font(.title)
            Spacer()
        })
        .padding(.leading)
    }
}

// MARK: HideKeyboard extension
extension SearchEventsScreen {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
