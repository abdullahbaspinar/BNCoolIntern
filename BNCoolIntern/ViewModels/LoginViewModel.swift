import Foundation
import Combine
import FirebaseAuth

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: String?

    let auth: AuthService

    init(auth: AuthService) {
        self.auth = auth
    }

    func login() async {
        // doğrulama
        if email.isEmpty {
            error = "Email required"
            return
        }
        
        if !isValidEmail(email) {
            error = "Invalid email format"
            return
        }
        
        if password.isEmpty {
            error = "Password required"
            return
        }
        
        if password.count < 6 {
            error = "Password too short"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await auth.signIn(email: email, password: password)
        } catch {
            // belirli firebase kimlik doğrulama hatalarını işle
            if let authError = error as? AuthErrorCode {
                switch authError.code {
                case .userNotFound:
                    self.error = "Account not found"
                case .wrongPassword:
                    self.error = "Wrong password"
                case .invalidEmail:
                    self.error = "Invalid email format"
                case .tooManyRequests:
                    self.error = "Too many attempts"
                case .networkError:
                    self.error = "Network error"
                case .userDisabled:
                    self.error = "Account disabled"
                case .invalidCredential:
                    self.error = "Invalid credentials"
                default:
                    self.error = "Login failed"
                }
            } else {
                self.error = "Unexpected error"
            }
        }
    }
    
    // email doğrulama yardımcısı
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
