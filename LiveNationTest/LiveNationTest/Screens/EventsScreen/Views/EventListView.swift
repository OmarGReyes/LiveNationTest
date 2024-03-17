//
//  EventListView.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import SwiftUI

struct EventListView: View {
    var event: EventEntity
    var body: some View {
        HStack(content: {
            CacheAsyncImage(url: event.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: Constants.imageWidthOf100,
                               height: Constants.imageHeightOf100)
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.imageWidthOf100,
                               height: Constants.imageHeightOf100)
                case .failure:
                    Image(systemName: Constants.eventListViewDefaultSystemImage)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Constants.imageWidthOf100,
                               height: Constants.imageHeightOf100)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading,
                   spacing: Constants.eventListViewTextSpacing) {
                Text(event.name)
                    .font(.caption)
                    .bold()
                    .lineLimit(Constants.lineLimit)
                Text(event.formattedDate)
                    .font(.system(size: Constants.eventListViewTextSize))
                if !event.venue.isEmpty {
                    Text(event.venue)
                        .font(.system(size: Constants.eventListViewTextSize))
                }
                Text(event.location)
                    .font(.system(size: Constants.eventListViewTextSize))
            }
        })
    }
}

#Preview {
    EventListView(event: EventEntity(
        id: "sdsgsg",
        name: "First Event",
        date: "2024-08-30",
        venue: "Some venuew",
        city: "New York",
        state: "NY",
        imageURLString: "https://s1.ticketm.net/dam/a/494/4a231626-0e28-4f17-b002-71cf03aab494_602141_EVENT_DETAIL_PAGE_16_9.jpg"))
}
