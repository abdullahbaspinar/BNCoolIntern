import Foundation
import FirebaseAuth
import Combine

@MainActor
final class AuthService: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        print("AuthService: Başlatılıyor...")
        setupAuthStateListener()
        print("AuthService: Mevcut kullanıcı: \(Auth.auth().currentUser?.email ?? "nil")")
    }
    
    deinit {
        if let listener = authStateListener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
    
    private func setupAuthStateListener() {
        print("AuthService: Kimlik doğrulama durumu dinleyicisi kuruluyor...")
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            print("AuthService: Kimlik doğrulama durumu değişti - kullanıcı: \(user?.email ?? "nil")")
            DispatchQueue.main.async {
                self?.currentUser = user
                self?.isAuthenticated = user != nil
                print("AuthService: Durum güncellendi - isAuthenticated: \(self?.isAuthenticated ?? false)")
            }
        }
    }
    


    func signIn(email: String, password: String) async throws {
        print("AuthService: Giriş yapılmaya çalışılıyor: \(email)")
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        currentUser = result.user
        isAuthenticated = true
        print("AuthService: Giriş başarılı: \(email)")
    }

    func signUp(email: String, password: String) async throws {
        print("AuthService: Kayıt yapılmaya çalışılıyor: \(email)")
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        currentUser = result.user
        isAuthenticated = true
        print("AuthService: Kayıt başarılı: \(email)")
    }

    func signOut() throws {
        print("AuthService: Çıkış yapılmaya çalışılıyor")
        try Auth.auth().signOut()
        currentUser = nil
        isAuthenticated = false
        print("AuthService: Çıkış başarılı")
    }
}
