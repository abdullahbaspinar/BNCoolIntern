import Foundation
import Combine
import FirebaseAuth

@MainActor
final class SignupViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var error: String?

    let auth: AuthService

    init(auth: AuthService) { self.auth = auth }

    func signup() async {
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
            error = "Password too short (min 6 characters)"
            return
        }
        
        if confirmPassword.isEmpty {
            error = "Confirm password required"
            return
        }
        
        if password != confirmPassword {
            error = "Passwords don't match"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await auth.signUp(email: email, password: password)
        } catch {
            // belirli firebase kimlik doğrulama hatalarını işle
            if let authError = error as? AuthErrorCode {
                switch authError.code {
                case .emailAlreadyInUse:
                    self.error = "Email already exists"
                case .invalidEmail:
                    self.error = "Invalid email"
                case .weakPassword:
                    self.error = "Password too weak"
                case .networkError:
                    self.error = "Network error"
                case .operationNotAllowed:
                    self.error = "Signup not allowed"
                case .quotaExceeded:
                    self.error = "Service temporarily unavailable"
                default:
                    self.error = "Signup failed"
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
