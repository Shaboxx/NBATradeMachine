import Foundation
import FirebaseFirestore

@MainActor
final class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()

    private init() {}

    func fetchTeams() async throws -> [Team] {
        let snap = try await db.collection("teams").getDocuments()
        print("[Firestore] teams snapshot: \(snap.documents.count) docs")
        return snap.documents.compactMap { doc in
            do { return try doc.data(as: Team.self) }
            catch {
                print("[Firestore] team decode failed for \(doc.documentID): \(error)")
                return nil
            }
        }
    }

    func fetchPlayers() async throws -> [Player] {
        let snap = try await db.collection("players").getDocuments()
        print("[Firestore] players snapshot: \(snap.documents.count) docs")
        return snap.documents.compactMap { doc in
            do { return try doc.data(as: Player.self) }
            catch {
                print("[Firestore] player decode failed for \(doc.documentID): \(error)")
                return nil
            }
        }
    }

    func fetchLeagueRules() async throws -> LeagueRules? {
        let doc = try await db.collection("leagueRules").document("2025-26").getDocument()
        do { return try doc.data(as: LeagueRules.self) }
        catch {
            print("[Firestore] leagueRules decode failed: \(error)")
            return nil
        }
    }
}
