import SwiftUI

struct LoginView: View {
    @StateObject private var vm: LoginViewModel
    @State private var showSignup = false
    
    init(authService: AuthService) {
        _vm = StateObject(wrappedValue: LoginViewModel(auth: authService))
    }
    
    var body: some View {
        ZStack {
                            // arka plan
            AppTheme.background
                .ignoresSafeArea()
            
                            // içerik
            VStack(spacing: AppTheme.spacingLarge) {
                Spacer()
                
                // başlık bölümü
                VStack(spacing: AppTheme.spacing) {
                    // logo/ikon
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [AppTheme.primaryColor.opacity(0.2), AppTheme.secondaryColor.opacity(0.2)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "video.fill")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(AppTheme.primaryColor)
                    }
                    
                    Text("Welcome")
                        .modifier(TitleTextStyle())
                    
                    Text("Sign in to continue watching")
                        .modifier(CaptionTextStyle())
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                // form kartı
                VStack(spacing: AppTheme.spacing) {
                    // email alanı
                    VStack(alignment: .leading, spacing: AppTheme.spacingTiny) {
                        Text("Email")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        TextField("Enter your email", text: $vm.email)
                            .textFieldStyle(ModernTextFieldStyle())
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                    
                    // şifre alanı
                    VStack(alignment: .leading, spacing: AppTheme.spacingTiny) {
                        Text("Password")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        SecureField("Enter your password", text: $vm.password)
                            .textFieldStyle(ModernTextFieldStyle())
                            .textContentType(.password)
                    }
                    
                    // giriş yap butonu
                    Button {
                        Task { await vm.login() }
                    } label: {
                        if vm.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.2)
                        } else {
                            Text("Sign In")
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(vm.isLoading)
                    
                                            // hata mesajı
                    if let error = vm.error {
                        Text(error)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(AppTheme.danger)
                            .padding(.horizontal, AppTheme.spacing)
                            .padding(.vertical, AppTheme.spacingSmall)
                            .background(AppTheme.danger.opacity(0.1))
                            .cornerRadius(AppTheme.cornerRadiusSmall)
                    }
                }
                .padding(AppTheme.spacingLarge)
                .modifier(GlassmorphismCard())
                .padding(.horizontal, AppTheme.spacing)
                
                // hesap oluştur butonu
                Button("Don't have an account? Create one") {
                    showSignup = true
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppTheme.primaryColor)
                .padding(.top, AppTheme.spacing)
                
                // geliştirici bilgisi
                Text("Developed by Abdullah Başpınar")
                    .font(.system(size: 10, weight: .light))
                    .foregroundColor(AppTheme.textSecondary.opacity(0.6))
                    .padding(.top, AppTheme.spacing)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showSignup) {
            SignupView(authService: vm.auth)
        }
    }
}

// mark: - modern textfield stili
struct ModernTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(AppTheme.spacing)
            .background(AppTheme.cardBG.opacity(0.5))
            .cornerRadius(AppTheme.cornerRadiusSmall)
                                    .overlay(
                            RoundedRectangle(cornerRadius: AppTheme.cornerRadiusSmall)
                                .stroke(AppTheme.primaryColor.opacity(0.1), lineWidth: 1)
                        )
    }
}
