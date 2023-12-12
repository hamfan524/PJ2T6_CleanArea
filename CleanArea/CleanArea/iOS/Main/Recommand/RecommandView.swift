//
//  RecommandView.swift
//  CleanArea
//
//  Created by 김건호 on 12/6/23.
//
import SwiftUI

struct RecommandView: View {
    @ObservedObject var apiViewModel: APIViewModel
    @StateObject var vm: RecommandVM
    @Environment(\.presentationMode) var presentationMode
    var residence: City?
    
    init(apiViewModel: APIViewModel, residence: City?) {
        self.apiViewModel = apiViewModel
        self.residence = residence
        self._vm = StateObject(wrappedValue: RecommandVM(policy: apiViewModel.policy!))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                headerView(title: "추천정책")
                Spacer()
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    ForEach(vm.recommandcellModels.indices, id: \.self) { index in
                        RecommandCell(model: $vm.recommandcellModels[index], residence: residence)
                        .frame(height: 70)
                        .padding()
                        
                    }
                }
                .onAppear {
                    vm.updateModels()
                }
                Spacer()
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
        }
    }
}

struct RecommandCell: View {
    @Binding var model: RecommandCellModel
    var residence: City?
    
    var body: some View {
        NavigationLink(
            destination: destinationView(for: model.destinationKey, cellName: model.name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        ) {
            HStack {
                Text(model.name)
                    .bold()
                    .foregroundStyle(.black)
                    .font(.system(size: 25))
                Text("\(model.count)")
                    .foregroundStyle(.gray)
                    .font(.system(size: 20))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.buttonGreen)
                    .bold()
            }
            .padding()
            .frame(height: 85)
            .background(Color.backgroundGreen)
            .cornerRadius(10)
        }
    }
    
    @ViewBuilder
    private func destinationView(for key: String, cellName: String) -> some View {
        switch key {
        case "일자리", "주거", "교육", "복지,문화", "참여,권리":
            RecommandDetailView(modelName: cellName, policies: model.policies, residence: residence)
        default:
            Text("Invalid destination key")
        }
    }
}

extension RecommandView {
    private func headerView(title: String) -> some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .bold()
                    .foregroundStyle(.mainGreen)
                    .padding(.top, 20)
            }
            Text(title)
                .font(.title)
                .bold()
                .foregroundStyle(.mainGreen)
                .padding(.top, 20)
            Spacer()
        }
        .padding(.horizontal)
    }
}
