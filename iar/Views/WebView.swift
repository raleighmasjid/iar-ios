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

struct WebLink: WebDestination {
    let url: String
    let title: String
}

struct WebView: View {
    
    typealias DoneAction = () -> Void
    
    @Environment(\.openURL) var openURL
    
    let destination: WebDestination
    let doneAction: DoneAction?
    @StateObject var helper: WebViewHelper = WebViewHelper()
    @State var showActions: Bool = false
    @State var showShare: Bool = false
    
    init(_ webDestination: WebDestination, done: DoneAction? = nil) {
        destination = webDestination
        doneAction = done
    }
    
    var body: some View {
        WebkitView(url: destination.url, helper: helper)
        .navigationTitle(destination.title)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if helper.isLoading {
                    ProgressView()
                }
                Button {
                    showActions = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
            
            ToolbarItem(placement: .navigationBarLeading) {
                if let doneAction = doneAction {
                    Button("Done") {
                        doneAction()
                    }
                }
            }
        }
        .alert(isPresented: $helper.hasExternalURL) {
            Alert(
                title: Text("Open in Safari?"),
                message: Text(helper.externalURL?.absoluteString ?? ""),
                primaryButton: .default(Text("Open"), action: {
                    if let url = helper.externalURL {
                        openURL(url)
                    }
                }), secondaryButton: .cancel())
        }
        .actionSheet(isPresented: $showActions) {
            ActionSheet(
                title: Text(currentURL()?.absoluteString ?? destination.url),
                buttons: [
                    .default(Text("Share")) {
                        showShare = true
                    },
                    .default(Text("Open in Browser")) {
                        if let url = currentURL() {
                            openURL(url)
                        }
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $showShare) {
            ShareSheet(activityItems: [currentURL() ?? destination.url])
        }
    }
    
    func currentURL() -> URL? {
        helper.currentURL ?? URL(string: destination.url)
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
    @Published var hasExternalURL: Bool = false
    var currentURL: URL?
    var externalURL: URL?
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        currentURL = webView.url
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
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(">> didFail \(error)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if let failingURLString = (error as NSError).userInfo[NSURLErrorFailingURLStringErrorKey] as? String,
           let failingURL = URL(string: failingURLString) {
            externalURL = failingURL
            hasExternalURL = true
        }
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print(">> webViewWebContentProcessDidTerminate")
    }
    
}
