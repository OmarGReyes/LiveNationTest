//
//  LargeProgressView.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import SwiftUI

struct LargeProgressView: View {
    var body: some View {
        Spacer()
        ProgressView()
            .controlSize(.large)
            .tint(Color.blue)
        Spacer()
    }
}

#Preview {
    LargeProgressView()
}
