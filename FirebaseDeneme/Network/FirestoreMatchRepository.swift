//
//  FirestoreMatchRepository.swift
//  FirebaseDeneme
//
//  Created by Yunus Emre ÖZŞAHİN on 27.07.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol MatchRepository {
    func addMatch(sport: String, playerIDs: [String], location: String, date: Date, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchMatches(sport: String, completion: @escaping (Result<[Match], Error>) -> Void)
    func removeMatch(matchId: String, completion: @escaping (Result<Void, Error>) -> Void)
}



class FirestoreMatchRepository: MatchRepository {
    private let db = Firestore.firestore()

    func addMatch(sport: String, playerIDs: [String], location: String, date: Date, completion: @escaping (Result<Void, Error>) -> Void) {
        let match = Match(id: UUID().uuidString, sport: sport, players: playerIDs, location: location, date: date)
        do {
            let _ = try db.collection("matches").addDocument(from: match) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func fetchMatches(sport: String, completion: @escaping (Result<[Match], Error>) -> Void) {
        db.collection("matches").whereField("sport", isEqualTo: sport).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let matches = snapshot?.documents.compactMap { doc -> Match? in
                    try? doc.data(as: Match.self)
                } ?? []
                completion(.success(matches))
            }
        }
    }

    func removeMatch(matchId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("matches").document(matchId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
