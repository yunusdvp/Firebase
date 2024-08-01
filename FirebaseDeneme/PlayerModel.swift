//
//  PlayerModel.swift
//  FirebaseDeneme
//
//  Created by Yunus Emre ÖZŞAHİN on 27.07.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Player: Codable {
    var id: String?
    var name: String
    var position: String
    var skillRating: Int
    var age: Int
    var sports: [String: Bool]
    var gender: String
    var profilePhotoURL: String?
}

struct Match: Codable {
    var id: String?
    var sport: String
    var players: [String]
    var location: String
    var date: Date
}
