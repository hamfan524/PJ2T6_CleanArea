//
//  MainView.swift
//  CleanArea
//
//  Created by 최동호 on 12/6/23.
//

import ComposableArchitecture

import SwiftUI

struct MainView: View {
    @Bindable var store: StoreOf<MainFeature>
        
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            TabView {
                VStack {
                    HStack {
                        Button {
                            store.send(.tabBackButton)
                        } label: {
                            Image(systemName: "chevron.left")
                                .bold()
                                .foregroundStyle(.mainGreen)
                                .padding(.top, 20)
                        }
                        Text("추천정책")
                            .font(.pretendardBold30)
                            .foregroundStyle(.mainGreen)
                            .padding(.top, 20)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    RecommandView(
                        store: Store(initialState: RecommandFeature.State(
                            recommandcellModels: store.recommandcellModels)) {
                                RecommandFeature()
                            }
                    )
                }
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag("Home")
                
                VStack {
                    HStack {
                        Button {
                            store.send(.tabBackButton)
                        } label: {
                            Image(systemName: "chevron.left")
                                .bold()
                                .foregroundStyle(.mainGreen)
                                .padding(.top, 20)
                        }
                        Text("인기정책")
                            .font(.pretendardBold30)
                            .foregroundStyle(.mainGreen)
                            .padding(.top, 20)
                        Spacer()
                    }
                    .padding(.horizontal)
                    ListView(
                        store: Store(initialState: ListFeature.State(
                            filteredPolicies: store.hotPolicies,
                            hearderTitle: "인기정책",
                            policies: store.hotPolicies,
                            tabType: .hot,
                            text: "")) {
                                ListFeature()
                            })
                }
                .tabItem {
                    Label("Hot", systemImage: "flame")
                }
                .tag("Hot")
                
                VStack {
                    HStack {
                        Button {
                            store.send(.tabBackButton)
                        } label: {
                            Image(systemName: "chevron.left")
                                .bold()
                                .foregroundStyle(.mainGreen)
                                .padding(.top, 20)
                        }
                        Text("즐겨찾기")
                            .font(.pretendardBold30)
                            .foregroundStyle(.mainGreen)
                            .padding(.top, 20)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ListView(
                        store: Store(initialState: ListFeature.State(
                            filteredPolicies: store.likePolicies,
                            hearderTitle: "즐겨찾기",
                            policies: store.likePolicies,
                            tabType: .like,
                            text: "")) {
                                ListFeature()
                            })
                }
                .tabItem {
                    Label("Like", systemImage: "star")
                }
                .tag("Like")
            }
            .accentColor(.buttonGreen)
        }
        .onAppear {
            store.send(.appearSet)
        }
        .navigationBarBackButtonHidden()
    }
}
