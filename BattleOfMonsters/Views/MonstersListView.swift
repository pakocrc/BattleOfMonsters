//
//  MonstersListView.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import SwiftUI

struct MonstersListView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(store.state.monsters) { monster in
                    MonsterCardView(monster: monster)
                        .accessibilityIdentifier("MonsterCardView-\(monster.id)")
                }
                .accessibilityIdentifier("MonsterCardViewHStackItems")
            }
            .accessibilityIdentifier("MonsterCardViewHStack")
        }
    }
}

#Preview {
    MonstersListView()
        .environmentObject(previewStore)
}
