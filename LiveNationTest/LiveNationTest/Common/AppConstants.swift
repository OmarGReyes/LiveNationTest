//
//  AppConstants.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

// MARK: - Constants
struct Constants {
    static let cacheAsyncImageScale = 1.0
    static let dateFormatterYyyyMMDd = "yyyy-MM-dd"
    static let noLocationAvailable = "No location available"
    static let ticketMasterHost = "app.ticketmaster.com"
    static let apiKey = "DW0E98NrxUIfDDtNN7ijruVSm60ryFLX"
    static let sizeOfSearchResponse = "50"
    static let imageHeightOf100: CGFloat = 100
    static let imageWidthOf100: CGFloat = 100
    static let lineLimit = 2
    static let networkTimeoutInterval = 20.0
    
    // MARK: EventListView
    static let eventListViewTextSpacing: CGFloat = 4
    static let eventListViewTextSize: CGFloat = 14
    static let eventListViewDefaultSystemImage = "clear"
    
    // MARK: CustomSearchBar
    static let customSearchBarDefaultSpacing: CGFloat = 15
    static let customSearchBarDefaultFontSize: CGFloat = 23
    static let customSearchBarDefaultPlaceholder = "Search"
    static let customSearchBarXImage = "x.circle"
    static let customSearchBarSearchLeftImage = "magnifyingglass"
    static let customSearchBarVerticalPadding: CGFloat = 10
    static let customSearchBarBackgrundOpacity: CGFloat = 0.05
    static let customSearchBarCornerRadius: CGFloat = 8
    
    // MARK: SearchEventsScreen
    static let searchEventsScreenVStackSpacing: CGFloat = 3
    static let searchEventsScreenErrorTitle = "An error has occurred"
    static let searchEventsScreenTitle = "Live Nation Search"
}
