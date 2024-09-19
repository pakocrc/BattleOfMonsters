//
//  MonstersBattleCardListView.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import SwiftUI

struct MonstersBattleCardListView: View {
    @EnvironmentObject var store: AppStore


    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .firstTextBaseline, spacing: 20, content: {
                MonsterBattleCardView(defaultName: "Player", monster: store.state.selectedMonster)
                    .accessibilityIdentifier("PlayerBattleCard")

                MonsterBattleCardView(defaultName: "Computer", monster: store.state.computerMonster)
                    .accessibilityIdentifier("ComputerBattleCard")
            })
            .padding(.horizontal, 10)
            .frame(height: 355)

            Spacer()
        }
        .accessibilityIdentifier("MonstersBattleCardListScrollView")
    }
}

struct MonstersBattleCardListView_Previews: PreviewProvider {
    static var previews: some View {
        MonstersBattleCardListView()
            .environmentObject(previewStore)
    }
}
