import Foundation
import FirebaseFirestore
import FirebaseCore

final class VideoService {
    private let db = Firestore.firestore()

    func fetchAllVideos() async throws -> [Video] {
        print("VideoService: Videolar getirilmeye başlanıyor...")
        print("VideoService: Firebase uygulaması yapılandırıldı: \(FirebaseApp.app() != nil)")
        print("VideoService: Firestore örneği: \(db)")
        
        do {
            print("VideoService: 'videos' koleksiyonundan veri getirilmeye çalışılıyor...")
            let snap = try await db.collection("videos").getDocuments()
            print("VideoService: Firestore'dan \(snap.documents.count) belge başarıyla alındı")
            
            if snap.documents.isEmpty {
                print("VideoService: 'videos' koleksiyonunda belge bulunamadı")
                print("VideoService: 'videos' koleksiyonu mevcut ama boş")
            }
            
            let items: [Video] = snap.documents.compactMap { doc in
                let data = doc.data()
                print("VideoService: Belge işleniyor \(doc.documentID)")
                print("VideoService: Belge veri anahtarları: \(Array(data.keys))")
                print("VideoService: Belge verisi: \(data)")
                
                guard
                    let title = data["title"] as? String,
                    let videoURL = data["videoURL"] as? String,
                    let thumbURL = data["thumbURL"] as? String
                else { 
                    print("VideoService: Belge ayrıştırılamadı \(doc.documentID)")
                    print("VideoService: title türü: \(type(of: data["title"]))")
                    print("VideoService: videoURL türü: \(type(of: data["videoURL"]))")
                    print("VideoService: thumbURL türü: \(type(of: data["thumbURL"]))")
                    return nil 
                }

                let createdAt: Date
                if let ts = data["createdAt"] as? Timestamp {
                    createdAt = ts.dateValue()
                    print("VideoService: Oluşturulma tarihi: \(createdAt)")
                } else {
                    createdAt = Date()
                    print("VideoService: Yedek olarak mevcut tarih kullanılıyor")
                }

                let video = Video(id: doc.documentID, title: title, videoURL: videoURL, thumbURL: thumbURL, createdAt: createdAt)
                print("VideoService: Video başarıyla oluşturuldu: \(video.title)")
                return video
            }
            
            print("VideoService: \(items.count) video döndürülüyor")
            print("VideoService: Tüm video başlıkları:")
            for (index, video) in items.enumerated() {
                print("   \(index + 1). \(video.title) (ID: \(video.id))")
            }
            return items
            
        } catch {
            print("VideoService: Videolar getirilirken hata: \(error)")
            print("VideoService: Hata detayları: \(error.localizedDescription)")
            
            // İzin hatası olup olmadığını kontrol et
            if let firestoreError = error as? FirestoreErrorCode {
                switch firestoreError.code {
                case .permissionDenied:
                    print("VideoService: İZİN REDDEDİLDİ - Firestore Güvenlik Kurallarını kontrol edin!")
                case .unavailable:
                    print("VideoService: ULAŞILAMAZ - Firebase bağlantısını kontrol edin!")
                case .notFound:
                    print("VideoService: BULUNAMADI - Koleksiyon adını kontrol edin!")
                default:
                    print("VideoService: Diğer Firestore hatası: \(firestoreError.code)")
                }
            }
            
            throw error
        }
    }
}
