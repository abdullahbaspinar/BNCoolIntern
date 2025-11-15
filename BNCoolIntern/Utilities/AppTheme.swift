import SwiftUI

struct AppTheme {
    // mark: - renkler
    static let background = Color("Background")
    static let cardBG = Color("CardBG")
    static let primaryColor = Color("Primary")
    static let secondaryColor = Color("Secondary")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let danger = Color("Danger")
    
    // mark: - boşluk
    static let spacing: CGFloat = 16
    static let spacingLarge: CGFloat = 24
    static let spacingSmall: CGFloat = 12
    static let spacingTiny: CGFloat = 8
    
    // mark: - köşe yuvarlaklığı
    static let cornerRadius: CGFloat = 16
    static let cornerRadiusLarge: CGFloat = 20
    static let cornerRadiusSmall: CGFloat = 12
    static let cornerRadiusTiny: CGFloat = 8
    
    // mark: - gölgeler
    static let shadowRadius: CGFloat = 12
    static let shadowOpacity: Float = 0.15
    static let shadowOffset = CGSize(width: 0, height: 4)
    
    // mark: - tipografi
    static let titleFont = Font.system(size: 28, weight: .bold)
    static let subtitleFont = Font.system(size: 20, weight: .semibold)
    static let bodyFont = Font.system(size: 16, weight: .regular)
    static let captionFont = Font.system(size: 15, weight: .medium)
    static let smallFont = Font.system(size: 14, weight: .regular)
}

// mark: - buton stilleri
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(
                color: AppTheme.primaryColor.opacity(0.3),
                radius: AppTheme.shadowRadius,
                x: AppTheme.shadowOffset.width,
                y: AppTheme.shadowOffset.height
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(AppTheme.primaryColor)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(AppTheme.cardBG)
            .cornerRadius(AppTheme.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                    .stroke(AppTheme.primaryColor.opacity(0.2), lineWidth: 1)
            )
            .shadow(
                color: .black.opacity(0.05),
                radius: 8,
                x: 0,
                y: 2
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(AppTheme.secondaryColor)
            .padding(.horizontal, AppTheme.spacing)
            .padding(.vertical, AppTheme.spacingSmall)
            .background(AppTheme.cardBG)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(AppTheme.secondaryColor.opacity(0.2), lineWidth: 1)
            )
            .shadow(
                color: .black.opacity(0.05),
                radius: 6,
                x: 0,
                y: 2
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// mark: - kart stilleri
struct GlassmorphismCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppTheme.cardBG)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(
                color: .black.opacity(Double(AppTheme.shadowOpacity)),
                radius: AppTheme.shadowRadius,
                x: AppTheme.shadowOffset.width,
                y: AppTheme.shadowOffset.height
            )
    }
}

// mark: - metin stilleri
struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppTheme.titleFont)
            .foregroundColor(AppTheme.textPrimary)
    }
}

struct SubtitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppTheme.subtitleFont)
            .foregroundColor(AppTheme.textPrimary)
    }
}

struct BodyTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppTheme.bodyFont)
            .foregroundColor(AppTheme.textPrimary)
    }
}

struct CaptionTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppTheme.captionFont)
            .foregroundColor(AppTheme.textSecondary)
    }
}

// mark: - parıltı efekti
struct ShimmerEffect: View {
    @State private var isAnimating = false
    
    var body: some View {
        LinearGradient(
            colors: [
                AppTheme.cardBG.opacity(0.6),
                AppTheme.cardBG.opacity(0.3),
                AppTheme.cardBG.opacity(0.6)
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
        .mask(
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.clear, .white.opacity(0.6), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .rotationEffect(.degrees(30))
                .offset(x: isAnimating ? 400 : -400)
        )
        .onAppear {
            withAnimation(
                .linear(duration: 1.5)
                .repeatForever(autoreverses: false)
            ) {
                isAnimating = true
            }
        }
    }
}
