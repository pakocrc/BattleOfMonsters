//
//  MonsterBattleCardView.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import SwiftUI

struct MonsterBattleCardView: View {
    var defaultName: String
    var monster: Monster?

    var body: some View {
        VStack(alignment: .center) {
            if let monster = monster {
                AsyncImage(url: URL(string: monster.imageUrl.absoluteString)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 250, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding([.horizontal, .top], 5)

                HStack(alignment: .center) {
                    ScreenTitleView(title: monster.name, font: .title, weight: .bold)
                        .padding(.leading)
                    Spacer()
                }

                Divider()

                MonsterBattleCardAbilitiesView(monster: monster)
                    .padding(.bottom)

            } else {
                VStack(alignment: .leading) {
                    ScreenTitleView(title: defaultName, font: .title, weight: .regular)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
        .background(Color(.secondarySystemBackground))
        .frame(width: 255, height: 350)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.25), radius: 10, x: -2, y: 3)
    }
}

#Preview {
    MonsterBattleCardView(defaultName: "Computer", monster: nil)
}

#Preview {
    MonsterBattleCardView(defaultName: "Player", monster: MonstersList().monsters[0])
}
