//
//  AppReducer.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import Foundation

typealias Reducer<State, Action> = (State, Action) -> State

let AppReducer: Reducer<AppState, AppActions> = { state, action in

    var mutatingState = state

    switch action {
        case .setMonsters(let monsters):
            mutatingState.monsters = monsters

        case .setSelected(let monster):
            mutatingState.selectedMonster = monster
            mutatingState.computerMonster = monster != nil ? mutatingState.monsters.randomElement() : nil
    }
    
    return mutatingState
}
