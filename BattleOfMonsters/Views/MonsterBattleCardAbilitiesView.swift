//
//  MonsterBattleCardAbilitiesView.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import SwiftUI

struct MonsterBattleCardAbilitiesView: View {
    var monster: Monster

    var body: some View {
        VStack(alignment: .leading) {
            ProgressView(value: Double(monster.hp), total: 100.0) {
                ScreenTitleView(title: "HP", font: .caption, weight: .regular)
            }
            .tint(Color(.systemGreen))
            .padding([.horizontal])

            ProgressView(value: Double(monster.attack), total: 100.0) {
                ScreenTitleView(title: "Attack", font: .caption, weight: .regular)
            }
            .tint(Color(.systemGreen))
            .padding([.horizontal])

            ProgressView(value: Double(monster.defense), total: 100.0) {
                ScreenTitleView(title: "Defense", font: .caption, weight: .regular)
            }
            .tint(Color(.systemGreen))
            .padding([.horizontal])

            ProgressView(value: Double(monster.speed), total: 100.0) {
                ScreenTitleView(title: "Speed", font: .caption, weight: .regular)
            }
            .tint(Color(.systemGreen))
            .padding([.horizontal])
        }
    }
}

#Preview {
    MonsterBattleCardAbilitiesView(monster: MonstersList().monsters[0])
}
