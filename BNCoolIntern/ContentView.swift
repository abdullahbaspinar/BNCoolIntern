//
//  ContentView.swift
//  BNCoolIntern
//
//  Created by Abdullah B on 13.08.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    @StateObject private var authService = AuthService()
    private let videoService = VideoService()
    @State private var isAuthenticated = false
    
    var body: some View {
        Group {
            if authService.isAuthenticated {
                VideoListView(videoService: videoService, authService: authService)
            } else {
                LoginView(authService: authService)
            }
        }
    }
}

#Preview {
    ContentView()
}
