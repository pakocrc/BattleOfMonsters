//
//  ApiResponse.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import Foundation

// - MARK: API Response
struct ApiResponse: Codable {
    let statusCode: Int
    let errorMessage: String?
    let monsters: [Monster]?

    init(statusCode: Int, errorMessage: String) {
        self.statusCode = statusCode
        self.errorMessage = errorMessage
        self.monsters = nil
    }

    init(statusCode: Int, monsters: [Monster]?) {
        self.statusCode = statusCode
        self.errorMessage = nil
        self.monsters = monsters
    }
}

// - MARK: Battle API Response
struct BattleApiResponse: Codable {
    let statusCode: Int
    let errorMessage: String?
    let battle: Battle?

    init(statusCode: Int, errorMessage: String) {
        self.statusCode = statusCode
        self.errorMessage = errorMessage
        self.battle = nil
    }

    init(statusCode: Int, battle: Battle) {
        self.statusCode = statusCode
        self.errorMessage = nil
        self.battle = battle
    }
}
