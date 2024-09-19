//
//  MonsterList.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import Foundation

#if DEBUG
let previewStore: AppStore = {
    let appState = AppState()

    let store = AppStore(initialState: appState, reducer: AppReducer)

    let monsters = MonstersList().monsters

    store.dispatch(.setMonsters(monsters))

    return store
}()

final class MonstersList {
    var monsters: [Monster] = (Bundle.main.decode("monsters.json") as [Monster])
}
#endif
