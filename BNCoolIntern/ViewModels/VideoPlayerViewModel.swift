import Foundation
import Combine

@MainActor
final class VideoPlayerViewModel: ObservableObject {
    let video: Video
    init(video: Video) { self.video = video }
}
