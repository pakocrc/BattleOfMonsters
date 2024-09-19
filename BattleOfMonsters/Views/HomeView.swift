//
//  HomeView.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 17/9/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: AppStore
    private let networkClient: NetworkClient = ApiNetworkClient()

    @State private var isPresentingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            ZStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    ScreenTitleView(title: "Battle of Monsters", font: .largeTitle, weight: .bold)
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("Title")

                    ScreenTitleView(title: "Select your monster", font: .title2, weight: .regular)
                        .accessibilityIdentifier("Subtitle")

                    MonstersListView()
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("MonstersListView")

                    MonstersBattleCardListView()
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("MonstersBattleCardListView")

                    ButtonView()
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("MonstersBattleCardListView")
                }
            }
            .padding(.all, 10)
        }
        .onAppear(perform: {
            networkClient.getMonsters { result in
                switch result {
                    case .success(let monsters):
                        if let monsters = (monsters as? [Monster]) {
                            store.dispatch(.setMonsters(monsters))
                        } else {
                            store.dispatch(.setMonsters([]))
                        }
                    case .failure(let error):
                        let monstersLocalResource = MonstersList().monsters
                        store.dispatch(.setMonsters(monstersLocalResource))
                        alertMessage = error.localizedDescription
                        isPresentingAlert = true
                }
            }
        })
        .alert(isPresented: $isPresentingAlert) {
            Alert(title: Text("Alert"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(previewStore)
}
