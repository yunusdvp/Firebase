//
//  ServiceContainer.swift
//  FirebaseDeneme
//
//  Created by Yunus Emre ÖZŞAHİN on 27.07.2024.
//

import Foundation

class ServiceContainer {
    static let shared = ServiceContainer()

    let playerRepository: PlayerRepository
    let matchRepository: MatchRepository

    private init() {
        self.playerRepository = FirestorePlayerRepository()
        self.matchRepository = FirestoreMatchRepository()
    }
}
