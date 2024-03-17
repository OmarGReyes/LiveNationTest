//
//  CacheAsyncImage.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import SwiftUI

// MARK: CacheAsyncImage
struct CacheAsyncImage<Content: View>: View {
    // MARK: - Properties
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    // MARK: - Initializer
    init(url: URL,
         scale: CGFloat = Constants.cacheAsyncImageScale,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    // MARK: - body
    var body: some View {
        if let cachedImage = ImageCache[url] {
            content(.success(cachedImage))
        } else {
            AsyncImage(url: url, scale: scale, transaction: transaction) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    // MARK: - Methods
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

// MARK: ImageCache class
fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }

        set {
            ImageCache.cache[url] = newValue
        }
    }
}
