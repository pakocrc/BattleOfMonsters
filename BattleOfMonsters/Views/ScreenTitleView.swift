//
//  ScreenTitleView.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import SwiftUI

struct ScreenTitleView: View {
    let title: String
    let font: Font
    let weight: Font.Weight

    init(title: String, font: Font, weight: Font.Weight) {
        self.title = title
        self.font = font
        self.weight = weight
    }

    var body: some View {
        Text(self.title)
            .foregroundColor(Color(.label))
            .font(self.font)
            .fontWeight(self.weight)
            .frame(alignment: .leading)
    }
}

#Preview {
    ScreenTitleView(title: "Battle of Monsters", font: .largeTitle, weight: .bold)
}
