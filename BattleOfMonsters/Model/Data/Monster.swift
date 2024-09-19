//
//  Monster.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import Foundation

final class Monster: Codable, Identifiable {
    var id: String
    var name: String
    var attack: Int
    var defense: Int
    var hp: Int
    var speed: Int
    var type: String
    var imageUrl: URL
}
