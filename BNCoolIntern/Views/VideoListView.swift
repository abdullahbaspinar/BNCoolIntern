import SwiftUI
import FirebaseAuth

struct VideoListView: View {
    @StateObject private var vm: VideoListViewModel
    @State private var showSignup = false
    @State private var showLogout = false
    @State private var showLogoutConfirmation = false
    @State private var currentUserEmail: String = ""
    private let authService: AuthService
    
    init(videoService: VideoService, authService: AuthService) {
        _vm = StateObject(wrappedValue: VideoListViewModel(service: videoService))
        self.authService = authService
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                                // arka plan
                AppTheme.background
                    .ignoresSafeArea()
                
                // içerik
                Group {
                if vm.isLoading {
                    loadingView
                } else if !vm.items.isEmpty {
                    VStack(spacing: AppTheme.spacing) {
                                                // yenileme bölümü
                        HStack {
                            Text("Random Videos")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                            
                            // yenile butonu
                            Button(action: {
                                    print("VideoListView: Yenile butonu tıklandı")
                                    Task { 
                                        await vm.fullRefresh() 
                                    }
                                }) {
                                HStack(spacing: 6) {
                                    Image(systemName: "arrow.clockwise")
                                        .font(.system(size: 14, weight: .medium))
                                    Text("Refresh")
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .foregroundColor(AppTheme.primaryColor)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(AppTheme.primaryColor.opacity(0.1))
                                .clipShape(Capsule())
                            }
                            .disabled(vm.isLoading)
                        }
                        .padding(.horizontal, AppTheme.spacing)
                        
                        videoGridView
                    }
                } else {
                    emptyStateView
                }
            }
            }
            .navigationTitle("Videos")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showLogout = true
                    }) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(AppTheme.primaryColor)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                                    // canlı butonu
                NavigationLink("Live") {
                        LiveStreamView()
                    }
                    .foregroundColor(AppTheme.danger)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, AppTheme.spacing)
                    .padding(.vertical, AppTheme.spacingSmall)
                    .background(AppTheme.cardBG)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(AppTheme.danger.opacity(0.3), lineWidth: 1)
                    )
                }
            }
            .task { 
                await vm.loadRandomThree()
                            // mevcut kullanıcı email'ini al
            if let user = Auth.auth().currentUser {
                currentUserEmail = user.email ?? "No email"
            }
            }
            .refreshable {
                print("VideoListView: Aşağı çekme yenileme tetiklendi")
                await vm.fullRefresh()
            }
            .alert("User Profile", isPresented: $showLogout) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) {
                    showLogout = false
                    showLogoutConfirmation = true
                }
            } message: {
                Text("Current user: \(Auth.auth().currentUser?.email ?? "No email")")
            }
            .alert("Confirm Logout", isPresented: $showLogoutConfirmation) {
                Button("Cancel", role: .cancel) {
                    showLogout = true
                }
                Button("Yes, Logout", role: .destructive) {
                    logout()
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
        }
    }
    
    // mark: - yükleme görünümü
    private var loadingView: some View {
        VStack(spacing: AppTheme.spacing) {
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.primaryColor))
            
            Text("Loading videos...")
                .modifier(CaptionTextStyle())
        }
    }
    
    // mark: - video grid görünümü (responsive 2 sütun)
    private var videoGridView: some View {
        GeometryReader { geometry in
            ScrollView {
                let spacing: CGFloat = 16
                let availableWidth = geometry.size.width - (spacing * 3) // 2 columns + 2 side margins + 1 middle spacing
                let cardWidth = availableWidth / 2
                
                LazyVGrid(
                    columns: [
                        GridItem(.fixed(cardWidth), spacing: spacing),
                        GridItem(.fixed(cardWidth), spacing: spacing)
                    ],
                    spacing: spacing
                ) {
                    ForEach(vm.items) { video in
                        NavigationLink(destination: VideoPlayerView(video: video)) {
                            VideoCard(video: video, cardWidth: cardWidth)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, spacing)
                .padding(.vertical, spacing)
            }
        }
    }
    
    // mark: - boş durum görünümü
    private var emptyStateView: some View {
        VStack(spacing: AppTheme.spacingLarge) {
            Image(systemName: "video.slash")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.textSecondary)
            
            Text("No Videos Available")
                .modifier(CaptionTextStyle())
            
            Text("Check back later for new content")
                .modifier(CaptionTextStyle())
                .multilineTextAlignment(.center)
            
            Button("Retry") {
                Task { await vm.fullRefresh() }
            }
            .buttonStyle(SecondaryButtonStyle())
            .frame(width: 120)
            
            // geliştirici bilgisi
            Text("Developed by Abdullah Başpınar")
                .font(.system(size: 10, weight: .light))
                .foregroundColor(AppTheme.textSecondary.opacity(0.6))
                .padding(.top, AppTheme.spacing)
        }
        .padding()
    }
    
    private func logout() {
        try? authService.signOut()
    }
    
    
}

// mark: - video kartı (responsive tasarım)
struct VideoCard: View {
    let video: Video
    let cardWidth: CGFloat
    
    var body: some View {
        VStack(spacing: 12) {
            // küçük resim
            ZStack {
                AsyncImage(url: URL(string: video.thumbURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ShimmerEffect()
                }
                .frame(width: cardWidth, height: cardWidth * 0.75) // 4:3 en boy oranı
                .clipped()
                .cornerRadius(16)
                
                // oynat butonu üst kaplaması
                Circle()
                    .fill(AppTheme.primaryColor.opacity(0.9))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "play.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    )
            }
            
            // başlık
            Text(video.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: 44) // tutarlılık için sabit yükseklik
                .frame(maxWidth: .infinity)
        }
        .frame(width: cardWidth)
        .onAppear {
            print("VideoCard: Video için görünür hale geldi: \(video.title)")
        }
    }
}
