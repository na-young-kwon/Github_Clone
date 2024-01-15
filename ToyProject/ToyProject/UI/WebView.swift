//
//  WebView.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import SwiftUI
import WebKit

protocol WebViewHandlerDelegate {
    func receivedJsonValueFromWebView(json: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}

enum WebUrlType {
    case localUrl, publicUrl
}

struct WebView: UIViewRepresentable, WebViewHandlerDelegate {
    let url: URL
    var urlType: WebUrlType
    
    func receivedJsonValueFromWebView(json: [String : Any?]) {
        // VM 에서 이 메서드를 호출해서 View를 바꾸도록 구현
        guard let functionName = json["Name"] as? String else {
            return
        }
        print("웹에서 JSON 데이터 받음: \(functionName)")
    }
    
    func receivedStringValueFromWebView(value: String) {
        // VM 에서 이 메서드를 호출해서 View를 바꾸도록 구현
        print("웹에서 String 데이터 받음: \(value)")
    }
    
    func didStartProvisionalNavigation() {
        print("✅ didStartProvisionalNavigation ✅")
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true // 이거 꼭 해줘야 자바스크립트 메서드 호출 가능
        
        let config = WKWebViewConfiguration()
        config.userContentController.add(context.coordinator, name: "callBackHandler")
        config.preferences = preferences
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator   // 웹의 탐색 동작을 관리하는데 사용하는 개체
        webView.allowsBackForwardNavigationGestures = true // 가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리거 하는지 여부
        webView.scrollView.isScrollEnabled = true          // 스크롤뷰에서 스크롤 가능 여부
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if urlType == .localUrl {
            if let url = Bundle.main.url(forResource: "LocalWebsite", withExtension: "html") {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        } else if urlType == .publicUrl {
            webView.load(URLRequest(url: url))
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        
        private let parent: WebView
        var delegate: WebViewHandlerDelegate?
        
        init(_ parent: WebView) {
            self.parent = parent
            self.delegate = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // 앱에서 -> 웹으로
            // 언제 호출해야 하는지를 모르겠음
            let value = "아이폰 14 프로"
            webView.evaluateJavaScript("valueGotFromIOS('\(value)');") { result, error in
                if let error = error {
                    print("Error Calling from JS function: \(error)")
                } else if let result = result { // 여긴 안타네
                    print("Received result from JS function: \(result)")
                }
            }
        }
        
        // MARK: WKNavigationDelegate
        
        // This function is essential for intercepting every navigation in the webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // Suppose you don't want your user to go a restricted site
            if let host = navigationAction.request.url?.host {
                if host == "restricted.com" {
                    // This cancels the navigation
                    decisionHandler(.cancel)
                }
            }
            // This allows the navigation
            decisionHandler(.allow)
        }
      
          // 2. decisionHandler(.allow)로 허가 났으면 navigation 시작
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Show loader
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            // Hides loader
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // Hides loader
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            // Hides loader
        }

    }
}

// MARK: - Extensions
extension WebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "callBackHandler" { // ios에서 메시지 핸들러를 추가할 때 지정한 이름
            if let body = message.body as? [String: Any?] {
                delegate?.receivedJsonValueFromWebView(json: body)
            } else if let body = message.body as? String {
                delegate?.receivedStringValueFromWebView(value: body)
            }
        }
    }
}
