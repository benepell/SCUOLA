//
//  VrScuolaApp.swift
//  VrScuola
//
//  Created by benedetto pellerito on 16/07/23.
//

//
//  VrScuolaApp.swift
//  VrScuola
//
//  Created by benedetto pellerito on 16/07/23.
//
//
//  VrScuolaApp.swift
//  VrScuola
//
//  Created by benedetto pellerito on 16/07/23.
//

//
//  VrScuolaApp.swift
//  VrScuola
//
//  Created by benedetto pellerito on 16/07/23.
//

//
//  VrScuolaApp.swift
//  VrScuola
//
//  Created by benedetto pellerito on 16/07/23.
//
//
//  VrScuolaApp.swift
//  VrScuola
//
//  Created by benedetto pellerito on 16/07/23.
//

import SwiftUI
import WebKit

@main
struct VrScuolaApp: App {
    var body: some Scene {
        WindowGroup {
            WebViewContainer()
        }
    }
}

struct WebViewContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> WebViewController {
        return WebViewController()
    }
    
    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {
        // Aggiorna l'interfaccia utente, se necessario
    }
}

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    private var webView: WKWebView!
    private let desktopUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36"
      
    var orientationObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        let userContentController: WKUserContentController = WKUserContentController()
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=0.45, maximum-scale=3.0, user-scalable=1';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        userContentController.addUserScript(script)
        webConfiguration.userContentController = userContentController
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        let userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4644.0 Safari/537.36"
        webView.customUserAgent = userAgent
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        webView.customUserAgent = desktopUserAgent

        
        orientationObserver = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.updateZoomScale()
        }
        
        if let url = URL(string: "https://scuola.vrscuola.it") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    deinit {
        if let observer = orientationObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func updateZoomScale() {
        webView.scrollView.minimumZoomScale = 0.6
        webView.scrollView.maximumZoomScale = 0.6
        webView.scrollView.setZoomScale(0.6, animated: true)
    }
    
    // MARK: WKNavigationDelegate methods
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Pagina web caricata correttamente.")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Errore nel caricamento della pagina web: \(error.localizedDescription)")
    }
}
