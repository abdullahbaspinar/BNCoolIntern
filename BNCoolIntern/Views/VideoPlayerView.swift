import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let video: Video
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
                            // arka plan
            AppTheme.background
                .ignoresSafeArea()
            
                            // video oynatıcı
            if video.videoURL.contains("youtu") {
                VStack {
                    Text("YouTube Video: \(video.title)")
                        .modifier(SubtitleTextStyle())
                        .padding()
                    
                    WebView(htmlString: youTubeEmbedHTML(from: video.videoURL))
                        .ignoresSafeArea(.all, edges: .top)
                        .onAppear {
                            print("🎥 VideoPlayerView: Loading YouTube video: \(video.videoURL)")
                            print("🎥 VideoPlayerView: Generated HTML: \(youTubeEmbedHTML(from: video.videoURL))")
                        }
                }
            } else if let url = URL(string: video.videoURL) {
                VStack {
                    Text("MP4 Video: \(video.title)")
                        .modifier(SubtitleTextStyle())
                        .padding()
                    
                    VideoPlayer(player: AVPlayer(url: url))
                        .ignoresSafeArea(.all, edges: .top)
                        .onAppear {
                            print("🎥 VideoPlayerView: Loading MP4 video: \(url)")
                        }
                }
            } else {
                invalidURLView
            }
            
            // üst üst kaplama
            VStack {
                // bulanık başlık
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
                    
                    // video başlığı
                    Text(video.title)
                        .modifier(SubtitleTextStyle())
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppTheme.spacing)
                        .padding(.vertical, AppTheme.spacingSmall)
                        .background(.ultraThinMaterial)
                        .cornerRadius(AppTheme.cornerRadius)
                    
                    Spacer()
                    
                    // paylaş butonu
                    Button(action: {
                        shareVideo()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, AppTheme.spacing)
                .padding(.top, 60) // güvenli alan ofseti
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("VideoPlayerView: Video ile görünür hale geldi: \(video.title)")
            print("VideoPlayerView: Video URL: \(video.videoURL)")
            print("VideoPlayerView: YouTube mu: \(video.videoURL.contains("youtu"))")
        }
    }
    
    // mark: - geçersiz url görünümü
    private var invalidURLView: some View {
        VStack(spacing: AppTheme.spacingLarge) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.danger)
            
            Text("Invalid Video URL")
                .modifier(SubtitleTextStyle())
            
            Text("This video cannot be played at the moment")
                .modifier(CaptionTextStyle())
                .multilineTextAlignment(.center)
            
            Text("URL: \(video.videoURL)")
                .modifier(CaptionTextStyle())
                .foregroundColor(AppTheme.textSecondary)
                .padding()
                .background(AppTheme.cardBG)
                .cornerRadius(AppTheme.cornerRadiusSmall)
            
            // geliştirici bilgisi
            Text("Developed by Abdullah Başpınar")
                .font(.system(size: 10, weight: .light))
                .foregroundColor(AppTheme.textSecondary.opacity(0.6))
                .padding(.top, AppTheme.spacing)
        }
        .padding()
    }
    
    // mark: - video paylaş
    private func shareVideo() {
        let activityVC = UIActivityViewController(
            activityItems: [video.title, video.videoURL],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityVC, animated: true)
        }
    }
}
