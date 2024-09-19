//
//  MonsterCardView.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import SwiftUI

struct MonsterCardView: View {
    @EnvironmentObject var store: AppStore
    var monster: Monster

    var isSelected: Bool {
        store.state.selectedMonster?.id == monster.id
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {

            AsyncImage(url: URL(string: self.monster.imageUrl.absoluteString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 136, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            ScreenTitleView(title: monster.name, font: .body, weight: .medium)
        }
        .frame(width: 150, height: 140)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.25), radius: 7, x: -2, y: 3)
        .padding(.horizontal, 5)
        .padding([.bottom, .top], 10)
        .scaleEffect(isSelected ? 1.1 : 1)
        .animation(.linear, value: 1)
        .onTapGesture {
            isSelected ? store.dispatch(.setSelected(nil)) : store.dispatch(.setSelected(monster))
        }
    }
}

struct MonstersCardView_Previews: PreviewProvider {
    static var previews: some View {
        let monsters = MonstersList().monsters

        MonsterCardView(monster: monsters[0])
            .environmentObject(previewStore)
    }
}
