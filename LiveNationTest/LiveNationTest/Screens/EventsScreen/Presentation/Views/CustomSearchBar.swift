//
//  CustomSearchBar.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    var onSubmitAction: () -> Void
    var onTapXButton: () -> Void
    
    var body: some View {
        HStack(spacing: Constants.customSearchBarDefaultSpacing) {
            Image(systemName: Constants.customSearchBarSearchLeftImage)
                .font(.system(size: Constants.customSearchBarDefaultFontSize,
                              weight: .bold))
                .foregroundColor(.gray)
            TextField(Constants.customSearchBarDefaultPlaceholder,
                      text: $searchText)
                .autocorrectionDisabled()
                .onSubmit {
                onSubmitAction()
            }
            Image(systemName: Constants.customSearchBarXImage)
                .foregroundColor(.gray)
                .onTapGesture {
                    onTapXButton()
                }
        }
        .padding(.vertical, Constants.customSearchBarVerticalPadding)
        .padding(.horizontal)
        .background(Color.primary.opacity(Constants.customSearchBarBackgrundOpacity))
        .cornerRadius(Constants.customSearchBarCornerRadius)
        .padding()
    }
}
