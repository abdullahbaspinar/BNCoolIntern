import Foundation

struct Video: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let title: String
    let videoURL: String
    let thumbURL: String
    let createdAt: Date
}
