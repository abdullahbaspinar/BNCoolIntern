import Foundation
import Combine

@MainActor
final class LiveStreamViewModel: ObservableObject {
    enum ScreenState: Equatable {
        case loading
        case notLive(title: String?)
        case showing(html: String, title: String?)
        case error(String)
    }

    @Published var state: ScreenState = .loading
    private let service: LiveStreamService

    init(service: LiveStreamService = LiveStreamService()) { 
        self.service = service
        print("LiveStreamViewModel: Servis ile başlatıldı")
    }

    func start() {
        print("LiveStreamViewModel: Canlı yayın izleme başlatılıyor")
        state = .loading
        
        service.listenLive { [weak self] live in
            Task { @MainActor in
                guard let self else { 
                    print("LiveStreamViewModel: Self nil, durum güncellenemiyor")
                    return 
                }
                
                guard let live = live else { 
                    print("LiveStreamViewModel: Canlı yayın verisi alınamadı")
                    self.state = .notLive(title: nil); 
                    return 
                }
                
                print("LiveStreamViewModel: Canlı yayın güncellemesi alındı - isLive: \(live.isLive), liveURL: \(live.liveURL)")
                
                if live.isLive, !live.liveURL.isEmpty {
                    let html = youTubeEmbedHTML(from: live.liveURL)
                    print("LiveStreamViewModel: Canlı yayın aktif, YouTube embed gösteriliyor")
                    self.state = .showing(html: html, title: live.title)
                } else {
                    print("LiveStreamViewModel: Canlı yayın aktif değil, canlı olmayan durum gösteriliyor")
                    self.state = .notLive(title: live.title)
                }
            }
        }
    }
}
