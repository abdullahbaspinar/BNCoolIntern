import Foundation
import Combine

@MainActor
final class VideoListViewModel: ObservableObject {
    @Published var items: [Video] = []
    @Published var isLoading = false
    @Published var error: String?

    private let service: VideoService
    private var allVideos: [Video] = [] // tüm videoları sakla

    init(service: VideoService) {
        self.service = service
        print("VideoListViewModel: Servis ile başlatıldı")
    }

    func loadRandomThree() async {
        print("VideoListViewModel: loadRandomThree başlatılıyor...")
        isLoading = true
        defer { isLoading = false }
        
        do {
            print("VideoListViewModel: service.fetchAllVideos() çağrılıyor...")
            let all = try await service.fetchAllVideos()
            print("VideoListViewModel: Servisten \(all.count) video alındı")
            
            // Tüm videoları sakla
            self.allVideos = all
            
            if all.count < 3 {
                // 3'ten az video varsa, hepsini göster
                self.items = all
                error = "Not enough videos in Firestore. (\(all.count) videos found)"
                print("VideoListViewModel: 3'ten az video mevcut, hepsi gösteriliyor \(all.count)")
            } else {
                // Mevcut tüm videolardan 3 farklı rastgele video seç
                let shuffled = all.shuffled()
                let selected = Array(shuffled.prefix(3))
                
                print("VideoListViewModel: Toplam mevcut video: \(all.count)")
                print("VideoListViewModel: Tüm videolar karıştırıldı ve ilk 3'ü seçildi:")
                for (index, video) in selected.enumerated() {
                    print("   \(index + 1). \(video.title) (ID: \(video.id))")
                }
                
                // Hangi videoların seçilmediğini göster
                let notSelected = all.filter { video in
                    !selected.contains { $0.id == video.id }
                }
                if !notSelected.isEmpty {
                    print("VideoListViewModel: Bu sefer seçilmeyen videolar:")
                    for (index, video) in notSelected.enumerated() {
                        print("   \(index + 1). \(video.title) (ID: \(video.id))")
                    }
                }
                
                self.items = selected
                error = nil
                print("VideoListViewModel: \(selected.count) rastgele video başarıyla yüklendi")
            }
        } catch {
            print("VideoListViewModel: Videolar yüklenirken hata: \(error)")
            self.error = error.localizedDescription
        }
    }
    
    // Mevcut videolardan yeni rastgele seçim ile manuel yenileme
    func refreshWithNewRandom() async {
        print("VideoListViewModel: Yeni rastgele seçim ile manuel yenileme yapılıyor...")
        
        if allVideos.count < 3 {
            print("VideoListViewModel: Rastgeleleştirmek için yeterli video yok (\(allVideos.count) toplam)")
            return
        }
        
        // Mevcut videolardan yeni rastgele seçim oluştur
        let shuffled = allVideos.shuffled()
        let selected = Array(shuffled.prefix(3))
        
        print("VideoListViewModel: \(allVideos.count) toplam videodan yeni rastgele seçim:")
        for (index, video) in selected.enumerated() {
            print("   \(index + 1). \(video.title) (ID: \(video.id))")
        }
        
        // Bu sefer hangi videoların seçilmediğini göster
        let notSelected = allVideos.filter { video in
            !selected.contains { $0.id == video.id }
        }
        if !notSelected.isEmpty {
            print("VideoListViewModel: Bu yenilemede seçilmeyen videolar:")
            for (index, video) in notSelected.enumerated() {
                print("   \(index + 1). \(video.title) (ID: \(video.id))")
            }
        }
        
        self.items = selected
        print("VideoListViewModel: Yeni rastgele seçim ile yenilendi")
    }
    
    // firebaseden veri çekme
    func refreshFromFirebase() async {
        print("VideoListViewModel: Firebase'den yeni veri çekiliyor...")
        await loadRandomThree()
    }
    
    // firebaseden veri çek ve rastgele seç
    func fullRefresh() async {
        print("VideoListViewModel: Tam yenileme başlatılıyor...")
        await refreshFromFirebase()
    }
}
