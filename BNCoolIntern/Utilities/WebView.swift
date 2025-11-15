// utilities/webview.swift
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlString: String
    
    init(htmlString: String) {
        self.htmlString = htmlString
        print("🌐 WebView: Initialized with HTML length: \(htmlString.count)")
        print("🌐 WebView: HTML preview: \(String(htmlString.prefix(200)))...")
    }

    func makeUIView(context: Context) -> WKWebView {
        print("🌐 WebView: Creating WKWebView...")
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.allowsPictureInPictureMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let wv = WKWebView(frame: .zero, configuration: config)
        wv.scrollView.isScrollEnabled = true
        wv.navigationDelegate = context.coordinator
        
        print("🌐 WebView: WKWebView created with config: \(config)")
        return wv
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("🌐 WebView: Loading HTML string...")
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("🌐 WebView: Started loading...")
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("🌐 WebView: Finished loading")
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("🌐 WebView: Failed to load with error: \(error)")
        }
    }
}

func youTubeEmbedHTML(from url: String) -> String {
    print("🔗 YouTube: Processing URL: \(url)")
    
    // tam youtube linki bekler; basit desenlerle id'yi çıkarır
    let id: String = {
        if let range = url.range(of: "v=") {
            let after = url[range.upperBound...]
            let videoId = String(after.split(separator: "&").first ?? "")
            print("🔗 YouTube: Extracted ID from v=: \(videoId)")
            return videoId
        }
        if let range = url.range(of: "youtu.be/") {
            let videoId = String(url[range.upperBound...].split(separator: "?").first ?? "")
            print("🔗 YouTube: Extracted ID from youtu.be: \(videoId)")
            return videoId
        }
        print("🔗 YouTube: Could not extract ID, using full URL")
        return url
    }()
    
    let htmlString = """
    <html>
      <head>
        <meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0'/>
        <style>
          html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            background-color: #000;
          }
          iframe {
            width: 100%;
            height: 100vh;
            border: none;
            background-color: #000;
          }
        </style>
      </head>
      <body>
        <iframe 
          src='https://www.youtube.com/embed/\(id)?playsinline=1&rel=0&modestbranding=1'
          frameborder='0' 
          allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
          allowfullscreen>
        </iframe>
      </body>
    </html>
    """
    
    print("🔗 YouTube: Generated HTML for ID: \(id)")
    return htmlString
}

#Preview {
    WebView(htmlString: youTubeEmbedHTML(from: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"))
}
