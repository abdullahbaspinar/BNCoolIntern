# BNCoolIntern - Junior Level Teknik Mülakat Soruları

## iOS Geliştirme & SwiftUI Temelleri

### 1. SwiftUI Temel Bilgisi
**Soru:** SwiftUI nedir? UIKit'ten farkı nedir?
**Beklenen Cevap:** SwiftUI Apple'ın yeni arayüz geliştirme aracı, kod yazarak ekran tasarlayabiliyorsun. UIKit ise eski yöntem, görsel olarak tasarlıyorsun

**Soru:** Bu projede `@Published` property wrapper'ı neden kullandın?
**Beklenen Cevap:** Ekrandaki bilgilerin otomatik güncellenmesi için. Örneğin video listesi değiştiğinde ekran kendiliğinden yenileniyor

**Soru:** `@State` ve `@Binding` arasındaki fark nedir?
**Beklenen Cevap:** `@State` ekranın kendi bilgisini tutar, `@Binding` ise üst ekrandan gelen bilgiyi kullanır

### 2. MVVM Architecture Temelleri
**Soru:** MVVM pattern'deki M, V, VM ne anlama geliyor?
**Beklenen Cevap:** Model (veri), View (ekran), ViewModel (iş mantığı). Veriyi, ekranı ve işlemleri ayrı ayrı tutuyoruz

**Soru:** Bu projede ViewModel'ler hangi dosyalarda bulunuyor?
**Beklenen Cevap:** ViewModels klasöründe, LoginViewModel, VideoListViewModel gibi dosyalar var

**Soru:** `ObservableObject` protokolü neden kullanılıyor?
**Beklenen Cevap:** SwiftUI'ın bu nesnedeki değişiklikleri takip edebilmesi için. Böylece veri değiştiğinde ekran otomatik güncelleniyor

### 3. Temel Swift Bilgisi
**Soru:** Swift'te `struct` ve `class` arasındaki fark nedir?
**Beklenen Cevap:** Struct değer kopyalayarak çalışır, class ise referans ile. Struct'lar daha güvenli çünkü değiştirilemez

**Soru:** `let` ve `var` arasındaki fark nedir?
**Beklenen Cevap:** `let` ile tanımlanan değişken değiştirilemez, `var` ile tanımlanan değiştirilebilir

**Soru:** Swift'te optional nedir? `?` ve `!` ne anlama geliyor?
**Beklenen Cevap:** Optional bir değerin olmayabileceği anlamına gelir. `?` güvenli, `!` ise zorla değer almaya çalışır (tehlikeli olabilir)

## Firebase Temel Entegrasyonu

### 4. Firebase Temel Bilgisi
**Soru:** Firebase nedir? Hangi servisleri kullandın?
**Beklenen Cevap:** Google'ın hazır sunucu hizmeti. Kullanıcı girişi ve veritabanı olarak kullandım

**Soru:** Firebase'i projeye nasıl ekledin?
**Beklenen Cevap:** GoogleService-Info.plist dosyasını ekledim ve Firebase kütüphanelerini projeye dahil ettim

**Soru:** Firestore'da veri nasıl saklanıyor?
**Beklenen Cevap:** JSON formatında, koleksiyon ve belge yapısında. Koleksiyonlar klasör gibi, belgeler ise dosya gibi

### 5. Temel Data Management
**Soru:** Video model'inde hangi bilgiler var?
**Beklenen Cevap:** id (benzersiz numara), title (başlık), videoURL (video linki), thumbURL (küçük resim linki), createdAt (oluşturulma tarihi)

**Soru:** `Codable` protokolü neden kullanılıyor?
**Beklenen Cevap:** İnternetten gelen JSON verisini Swift nesnesine, Swift nesnesini de JSON'a çevirmek için

**Soru:** `Identifiable` protokolü neden gerekli?
**Beklenen Cevap:** SwiftUI'da liste oluştururken her öğenin benzersiz bir kimliği olması gerekiyor

## Video & Media Temel Bilgisi

### 6. Video Playback Temelleri
**Soru:** Projede hangi video oynatıcıları kullandın?
**Beklenen Cevap:** WebView (YouTube videoları için), AVPlayer (MP4 dosyaları için)

**Soru:** WebView nedir? Neden kullandın?
**Beklenen Cevap:** Web sayfalarını gösterebilen bir bileşen. YouTube videolarını göstermek için kullandım

**Soru:** Video küçük resimlerini nasıl gösteriyorsun?
**Beklenen Cevap:** AsyncImage ile internetten yükleyerek. Bu sayede videolar yüklenirken önce küçük resimler görünüyor

### 7. Live Streaming Temelleri
**Soru:** Live streaming nedir?
**Beklenen Cevap:** Canlı yayın, gerçek zamanlı video akışı. Kullanıcılar aynı anda izleyebiliyor

**Soru:** Neden YouTube live stream kullandın?
**Beklenen Cevap:** YouTube'un hazır ve güvenilir canlı yayın altyapısı var. Kendi sunucu kurmak çok karmaşık olurdu

## Temel Performance & User Experience

### 8. Basit Performance Konuları
**Soru:** Loading state nedir? Neden kullandın?
**Beklenen Cevap:** Veri yüklenirken kullanıcıya "yükleniyor" mesajı göstermek için. Kullanıcı boş ekran görünce şaşırmıyor

**Soru:** Pull-to-refresh nedir?
**Beklenen Cevap:** Ekranı aşağı çekerek yenileme özelliği. Instagram'da da var, aşağı çekince yeni gönderiler geliyor

**Soru:** Error handling nedir? Neden önemli?
**Beklenen Cevap:** Hataları yakalayıp kullanıcıya anlaşılır mesaj göstermek için. Uygulama çökmeden kullanıcı ne olduğunu anlıyor

### 9. Temel User Experience
**Soru:** Toast notification nedir?
**Beklenen Cevap:** Ekranın altında kısa süreli bilgi mesajı. "Giriş başarılı" gibi mesajlar için kullanılıyor

**Soru:** Neden loading indicator kullandın?
**Beklenen Cevap:** Kullanıcıya işlemin devam ettiğini göstermek için. Dönen çember gibi animasyonlar kullanıcıyı bekletiyor

## Code Organization & Best Practices

### 10. Temel Code Organization
**Soru:** Proje klasör yapısını nasıl organize ettin?
**Beklenen Cevap:** Models (veri yapıları), Views (ekranlar), ViewModels (iş mantığı), Services (sunucu işlemleri) klasörleri oluşturdum

**Soru:** Neden farklı dosyalara böldün?
**Beklenen Cevap:** Kod daha okunabilir olsun diye. Her dosyada tek bir iş yapılıyor, karışıklık olmuyor

**Soru:** Service layer nedir?
**Beklenen Cevap:** Sunucu ile konuşan kodları ayrı tutmak için. Firebase'den veri çekme, kullanıcı girişi gibi işlemler burada

### 11. Temel Testing & Debugging
**Soru:** Xcode'da debugging nasıl yapıyorsun?
**Beklenen Cevap:** Breakpoint koyarak kodun o noktada durmasını sağlıyorum, print ile ekrana bilgi yazdırıyorum

**Soru:** Console'da hangi hataları gördün?
**Beklenen Cevap:** Firebase bağlantı hataları, internet bağlantı sorunları, veri yükleme hataları

**Soru:** SwiftUI Preview nedir?
**Beklenen Cevap:** Ekranı Xcode'da önizleme yapabilmek için. Kod yazarken hemen sonucu görebiliyorsun

## Temel iOS Bilgisi

### 12. iOS App Temelleri
**Soru:** iOS app'in minimum version'ı neden 16.0?
**Beklenen Cevap:** SwiftUI'ın yeni özellikleri ve async/await desteği için. Eski versiyonlarda bu özellikler yok

**Soru:** AppDelegate nedir?
**Beklenen Cevap:** Uygulama açılışında, kapanışında çalışan kodları yöneten sınıf. Firebase'i başlatmak için kullandım

**Soru:** Bundle identifier nedir?
**Beklenen Cevap:** Uygulamanın benzersiz kimliği. App Store'da her uygulamanın farklı bir kimliği olması gerekiyor

### 13. Temel iOS Components
**Soru:** NavigationView nedir?
**Beklenen Cevap:** Sayfalar arası geçiş yapmak için kullanılan bileşen. Üstte geri butonu çıkıyor

**Soru:** List ve ForEach arasındaki fark nedir?
**Beklenen Cevap:** List kaydırılabilir liste yapar, ForEach ise sadece tekrarlama yapar. List içinde ForEach kullanıyorsun

**Soru:** AsyncImage nedir?
**Beklenen Cevap:** İnternetten resim yükleyen bileşen. Resim yüklenirken placeholder gösteriyor

## Project-Specific Temel Sorular

### 14. BNCoolIntern Temel Bilgisi
**Soru:** Bu proje ne yapıyor?
**Beklenen Cevap:** Video izleme uygulaması. Kullanıcı girişi yapıp video listesi görebiliyor, videoları oynatabiliyor ve canlı yayın izleyebiliyor

**Soru:** Kaç ekran var? Hangi ekranlar?
**Beklenen Cevap:** 5 ekran: Giriş ekranı, Kayıt ekranı, Video listesi, Video oynatıcı, Canlı yayın

**Soru:** Neden 3 rastgele video gösteriyorsun?
**Beklenen Cevap:** Proje gereksiniminde belirtilmiş. Her seferinde farklı videolar göstererek çeşitlilik sağlıyor

### 15. Temel Authentication
**Soru:** Authentication nedir?
**Beklenen Cevap:** Kullanıcı girişi yapma, kimlik doğrulama. Kullanıcının gerçekten o kişi olduğunu kanıtlama

**Soru:** Firebase Auth ile ne yapıyorsun?
**Beklenen Cevap:** Email ve şifre ile kullanıcı kaydı ve girişi. Kullanıcı bilgilerini güvenli şekilde saklıyorum

**Soru:** User session nedir?
**Beklenen Cevap:** Kullanıcının giriş yapmış durumu. Uygulama kapanıp açılsa bile giriş yapmış kalıyor

## Behavioral & Learning Questions

### 16. Temel Problem Solving
**Soru:** Bu projeyi yaparken en zor neydi?
**Beklenen Cevap:** Firebase'i projeye eklemek ve SwiftUI'ı öğrenmek. Yeni teknolojiler olduğu için zaman aldı

**Soru:** Bir sorunla karşılaştığında ne yapıyorsun?
**Beklenen Cevap:** Önce Google'da arıyorum, Stack Overflow'da benzer sorunları buluyorum, Apple'ın resmi dokümantasyonuna bakıyorum

**Soru:** Bu projeyi tekrar yapsan neyi farklı yapardın?
**Beklenen Cevap:** Hata mesajlarını daha iyi yazardım, ekran tasarımını daha güzel yapardım, daha fazla test yazardım

### 17. Learning & Growth
**Soru:** Bu projeden ne öğrendin?
**Beklenen Cevap:** SwiftUI ile ekran tasarlamayı, Firebase ile sunucu işlemlerini, MVVM mimarisini, asenkron programlamayı öğrendim

**Soru:** Hangi teknolojileri ilk kez kullandın?
**Beklenen Cevap:** SwiftUI, Firebase, Combine framework. Hepsi yeni teknolojilerdi

**Soru:** iOS development'da ne öğrenmek istiyorsun?
**Beklenen Cevap:** Core Data ile veri saklama, networking ile internet işlemleri, UI/UX tasarım prensipleri

## Temel Technical Questions

### 18. Swift Temel Özellikleri
**Soru:** Swift'te closure nedir?
**Beklenen Cevap:** Fonksiyon gibi davranan kod bloğu. Değişken olarak saklanabilir ve sonradan çalıştırılabilir

**Soru:** `guard` statement nedir?
**Beklenen Cevap:** Erken çıkış için kullanılan kontrol. Koşul sağlanmazsa fonksiyondan çıkıyor

**Soru:** `defer` nedir?
**Beklenen Cevap:** Fonksiyon sonunda mutlaka çalışması gereken kod. Temizlik işlemleri için kullanılıyor

### 19. Temel iOS Development
**Soru:** Storyboard vs SwiftUI farkı nedir?
**Beklenen Cevap:** Storyboard görsel olarak tasarlanıyor, SwiftUI ise kod yazarak tasarlanıyor. SwiftUI daha modern

**Soru:** Simulator nedir?
**Beklenen Cevap:** iOS uygulamasını test etmek için kullanılan sanal telefon. Bilgisayarda iPhone gibi davranıyor

**Soru:** Build nedir?
**Beklenen Cevap:** Yazdığın kodu çalıştırılabilir uygulamaya dönüştürme işlemi. Xcode bunu otomatik yapıyor

## Mülakat Değerlendirme Kriterleri - Junior Level

### Temel Seviye (0-1 yıl deneyim)
- SwiftUI temel bilgisi
- MVVM pattern anlayışı
- Firebase basic integration
- Temel error handling

### Gelişen Seviye (1-2 yıl deneyim)
- SwiftUI intermediate features
- Basic architecture understanding
- Simple performance awareness
- Basic testing knowledge

---

**Not:** Bu sorular junior seviye iOS developer'lar için hazırlanmıştır. Temel bilgiler ve giriş seviyesi konulara odaklanılmıştır.
