import Foundation
import FirebaseStorage

@MainActor
final class StorageService {
    static let shared = StorageService()
    private let storage = Storage.storage()
    private var cache: [String: URL] = [:]

    private init() {}

    func headshotURL(for slug: String) async -> URL? {
        await url(at: "headshots/\(slug).png")
    }

    func logoURL(for teamId: String) async -> URL? {
        await url(at: "logos/\(teamId).png")
    }

    private func url(at path: String) async -> URL? {
        if let cached = cache[path] { return cached }
        do {
            let downloaded = try await storage.reference(withPath: path).downloadURL()
            cache[path] = downloaded
            return downloaded
        } catch {
            return nil
        }
    }
}
