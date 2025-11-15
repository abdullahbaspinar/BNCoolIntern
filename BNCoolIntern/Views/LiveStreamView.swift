import SwiftUI

struct LiveStreamView: View {
    @StateObject private var vm: LiveStreamViewModel
    @Environment(\.dismiss) private var dismiss
    
    init() { 
        _vm = StateObject(wrappedValue: LiveStreamViewModel())
    }

    var body: some View {
        ZStack {
                            // arka plan
            AppTheme.background
                .ignoresSafeArea()
            
                            // duruma göre içerik
            switch vm.state {
            case .loading:
                loadingView
                
            case .notLive(let title):
                notLiveView(title: title)
                
            case .showing(let html, let title):
                liveStreamView(html: html, title: title)
                
            case .error(let message):
                errorView(message: message)
            }
            
            // üst üst kaplama geri butonu ile
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, AppTheme.spacing)
                .padding(.top, 60) // güvenli alan ofseti
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear { 
            print("LiveStreamView: Görünür hale geldi, canlı yayın izleme başlatılıyor")
            vm.start() 
        }
    }
    
    // mark: - yükleme görünümü
    private var loadingView: some View {
        VStack(spacing: AppTheme.spacing) {
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.primaryColor))
            
            Text("Connecting to live stream...")
                .modifier(CaptionTextStyle())
        }
    }
    
    // mark: - canlı olmayan görünüm
    private func notLiveView(title: String?) -> some View {
        VStack(spacing: AppTheme.spacingLarge) {
            Image(systemName: "dot.radiowaves.left.and.right")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.textSecondary)
            
            Text(title ?? "No Live Stream Available")
                .modifier(SubtitleTextStyle())
                .multilineTextAlignment(.center)
            
            Text("The stream will appear automatically when it starts")
                .modifier(CaptionTextStyle())
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
            
            // geliştirici bilgisi
            Text("Developed by Abdullah Başpınar")
                .font(.system(size: 10, weight: .light))
                .foregroundColor(AppTheme.textSecondary.opacity(0.6))
                .padding(.top, AppTheme.spacing)
        }
        .padding(AppTheme.spacingLarge)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        .padding(.horizontal, AppTheme.spacing)
    }
    
    // mark: - canlı yayın görünümü
    private func liveStreamView(html: String, title: String?) -> some View {
        VStack(spacing: 0) {
            WebView(htmlString: html)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    print("LiveStreamView: WebView HTML uzunluğu ile görünür hale geldi: \(html.count)")
                }
        }
        .navigationTitle(title ?? "Live Stream")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // mark: - hata görünümü
    private func errorView(message: String) -> some View {
        VStack(spacing: AppTheme.spacingLarge) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.danger)
            
            Text("Error")
                .modifier(SubtitleTextStyle())
            
            Text(message)
                .modifier(CaptionTextStyle())
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
