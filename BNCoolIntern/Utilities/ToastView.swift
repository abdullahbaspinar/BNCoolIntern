import SwiftUI

struct ToastView: View {
    let message: String
    let type: ToastType
    @Binding var isShowing: Bool
    
    enum ToastType {
        case success
        case error
        case info
        
        var backgroundColor: Color {
            switch self {
            case .success:
                return .green
            case .error:
                return .red
            case .info:
                return .blue
            }
        }
        
        var icon: String {
            switch self {
            case .success:
                return "checkmark.circle.fill"
            case .error:
                return "exclamationmark.triangle.fill"
            case .info:
                return "info.circle.fill"
            }
        }
    }
    
    var body: some View {
        HStack(spacing: AppTheme.spacing) {
            Image(systemName: type.icon)
                .foregroundColor(.white)
                .font(.title2)
            
            Text(message)
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isShowing = false
                }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.title2)
            }
        }
        .padding(AppTheme.spacing)
        .background(type.backgroundColor)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: 8, x: 0, y: 4)
        .padding(.horizontal, AppTheme.spacing)
        .transition(.move(edge: .top).combined(with: .opacity))
        .onAppear {
            // 4 saniye sonra otomatik gizle
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isShowing = false
                }
            }
        }
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let type: ToastView.ToastType
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowing {
                VStack {
                    ToastView(message: message, type: type, isShowing: $isShowing)
                    Spacer()
                }
                .zIndex(1000)
            }
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String, type: ToastView.ToastType = .info) -> some View {
        modifier(ToastModifier(isShowing: isShowing, message: message, type: type))
    }
}
