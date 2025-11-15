import Foundation

struct LiveStream: Codable, Equatable {
    let isLive: Bool
    let liveURL: String
    let title: String?
    let startedAt: Date?
    let thumbURL: String?
}
