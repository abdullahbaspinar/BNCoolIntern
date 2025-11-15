import SwiftUI

struct SignupView: View {
    @StateObject private var vm: SignupViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(authService: AuthService) {
        _vm = StateObject(wrappedValue: SignupViewModel(auth: authService))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // arka plan
                AppTheme.background
                    .ignoresSafeArea()
                
                // içerik
                VStack(spacing: AppTheme.spacingLarge) {
                    // üst boşluk
                  
                    
                    // başlık
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
                            
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(AppTheme.primaryColor)
                        }
                        .padding(.top, 20)
                        
                        Text("Create Account")
                            .modifier(TitleTextStyle())
                        
                        Text("Join us to start watching")
                            .modifier(CaptionTextStyle())
                            .multilineTextAlignment(.center)
                    }
                    
                  
                    
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
                                .textContentType(.newPassword)
                        }
                        
                        // şifre onay alanı
                        VStack(alignment: .leading, spacing: AppTheme.spacingTiny) {
                            Text("Confirm Password")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            SecureField("Confirm your password", text: $vm.confirmPassword)
                                .textFieldStyle(ModernTextFieldStyle())
                                .textContentType(.newPassword)
                        }
                        
                        // hesap oluştur butonu
                        Button {
                            Task { await vm.signup() }
                        } label: {
                            if vm.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(1.2)
                            } else {
                                Text("Create Account")
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
                     
                     // geliştirici bilgisi
                     Text("Developed by Abdullah Başpınar")
                         .font(.system(size: 10, weight: .light))
                         .foregroundColor(AppTheme.textSecondary.opacity(0.6))
                         .padding(.top, AppTheme.spacing)
                 }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                                            Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.primaryColor)
                            .padding(10)
                            .background(AppTheme.primaryColor.opacity(0.1))
                            .clipShape(Circle())
                    }
                    }
                }
            }
            .onChange(of: vm.isLoading) { oldValue, newValue in
                if !newValue && vm.error == nil {
                    dismiss()
                }
            }
        }
    }
    #Preview {
        SignupView(authService: AuthService())
    }
}
