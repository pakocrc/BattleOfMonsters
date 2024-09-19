//
//  BattleOfMonstersApp.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 17/9/24.
//

import SwiftUI

@main
struct BattleOfMonstersApp: App {
    let store = AppStore(initialState: AppState(), reducer: AppReducer)

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(store)
        }
    }
}
