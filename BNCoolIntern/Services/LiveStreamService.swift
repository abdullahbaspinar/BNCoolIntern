import Foundation
import FirebaseFirestore

final class LiveStreamService {
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    deinit { 
        print("LiveStreamService: Sonlandırılıyor, dinleyici kaldırılıyor")
        listener?.remove() 
    }

    func listenLive(onChange: @escaping (LiveStream?) -> Void) {
        print("LiveStreamService: config/live için snapshot dinleyicisi kuruluyor")
        
        listener?.remove()
        listener = db.collection("config").document("live").addSnapshotListener { snap, error in
            if let error = error {
                print("LiveStreamService: Canlı yapılandırma dinlenirken hata: \(error)")
                onChange(nil)
                return
            }
            
            guard let data = snap?.data() else { 
                print("LiveStreamService: Canlı yapılandırma belgesinde veri yok")
                onChange(nil); 
                return 
            }
            
            print("LiveStreamService: Canlı yapılandırma güncellemesi alındı: \(data)")
            
            let isLive = data["isLive"] as? Bool ?? false
            let liveURL = data["liveURL"] as? String ?? ""
            let title = data["title"] as? String
            let startedAt = (data["startedAt"] as? Timestamp)?.dateValue()
            let thumbURL = data["thumbURL"] as? String
            
            let liveStream = LiveStream(
                isLive: isLive, 
                liveURL: liveURL, 
                title: title, 
                startedAt: startedAt, 
                thumbURL: thumbURL
            )
            
            print("LiveStreamService: LiveStream ayrıştırıldı - isLive: \(isLive), liveURL: \(liveURL), title: \(title ?? "nil")")
            onChange(liveStream)
        }
    }
}
