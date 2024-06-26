//
//  StartTextField.swift
//  CleanArea
//
//  Created by 최동호 on 12/5/23.
//

import ComposableArchitecture

import SwiftUI

struct StartTextField: View {
    @Bindable var store: StoreOf<TextFieldFeature>

    var body: some View {
        VStack {
            HStack {
                Text(store.type.title)
                    .font(.pretendardRegular20)
                    .foregroundStyle(.mainGreen)
                    .padding(.top, 10)
                Spacer()
            }
            .frame(maxWidth: .infinity)

            if store.type.isSelectable {
                SelectBox(store: store)
            } else {
                switch store.type {
                case .age:
                    TextField(store.type.placeholder, text: $store.text.sending(\.setName))
                        .commonTextFieldStyle(width: CGFloat(store.width), keyboardType: .decimalPad)

                case .policyName:
                    TextField(store.type.placeholder, text: $store.text.sending(\.setName))
                        .commonTextFieldStyle(width: CGFloat(store.width))
                    
                default:
                    fatalError("error")
                }
            }
        }
    }
}
