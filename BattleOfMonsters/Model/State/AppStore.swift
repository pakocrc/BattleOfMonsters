//
//  AppStore.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import Foundation
import Combine

typealias AppStore = Store<AppState, AppActions>

final class Store<State, Action>: ObservableObject {
    @Published private (set) var state: State

    private let reducer: Reducer<State, Action>
    private var subscription: Set<AnyCancellable> = []

    init(initialState: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    func dispatch(_ action: Action) {
        DispatchQueue.main.async { [self] in
            self.dispatch(self.state, action)
        }
    }

    private func dispatch(_ currentState: State, _ action: Action) {
        let newState = reducer(currentState, action)
        state = newState
    }
}
