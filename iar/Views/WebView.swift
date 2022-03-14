//
//  WebView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI
import WebKit

protocol WebDestination {
    var url: String { get }
    var title: String { get }
}

struct WebView: View {
    
    typealias DoneAction = () -> Void
    
    let destination: WebDestination
    let doneAction: DoneAction?
    let progressPlacement: ToolbarItemPlacement
    let donePlacement: ToolbarItemPlacement
    @StateObject var helper: WebViewHelper = WebViewHelper()
    
    init(_ webDestination: WebDestination, done: DoneAction? = nil) {
        destination = webDestination
        doneAction = done
        if done == nil {
            progressPlacement = .navigationBarTrailing
            donePlacement = .navigationBarLeading
        } else {
            progressPlacement = .navigationBarLeading
            donePlacement = .navigationBarTrailing
        }
    }
    
    var body: some View {
        WebkitView(url: destination.url, helper: helper)
        .navigationTitle(destination.title)
        .toolbar {
            ToolbarItem(placement: progressPlacement) {
                if helper.isLoading {
                    ProgressView()
                }
            }
            
            ToolbarItem(placement: donePlacement) {
                if let doneAction = doneAction {
                    Button("Done") {
                        doneAction()
                    }
                }
            }
        }
    }
}


struct WebkitView: UIViewRepresentable {
    let url: String
    let helper: WebViewHelper
     
    func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = helper
        wkWebView.uiDelegate = helper
        return wkWebView
    }
 
    func updateUIView(_ wkWebView: WKWebView, context: Context) {
        if let validURL = URL(string: url) {
            let request = URLRequest(url: validURL)
            wkWebView.load(request)
        }
    }
}

class WebViewHelper: NSObject, ObservableObject, WKNavigationDelegate, WKUIDelegate {

    @Published var isLoading: Bool = false
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isLoading = true
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
