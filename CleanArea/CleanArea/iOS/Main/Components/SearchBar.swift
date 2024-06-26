//
//  SearchBar.swift
//  CleanArea
//
//  Created by 최동호 on 12/11/23.
//
import ComposableArchitecture

import SwiftUI

struct SearchBar: View {
    @Bindable var store: StoreOf<ListFeature>
    
    var body: some View {
        HStack {
            TextField("정책이름을 검색해 주세요", text: $store.text.sending(\.setText))
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if store.text != "" {
                            Button(action: {
                                store.send(.clearTextField)
                                hideKeyboard()
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    })
        }
    }
}
