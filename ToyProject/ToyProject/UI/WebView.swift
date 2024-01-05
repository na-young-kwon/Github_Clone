//
//  WebView.swift
//  ToyProject
//
//  Created by nayoung kwon on 12/27/23.
//

import SwiftUI
import WebKit

enum WebUrlType {
    case localUrl, publicUrl
}

struct WebView: UIViewRepresentable {
    let url: URL
    var urlType: WebUrlType
    
    static let webMessage = "fromWebPage"
    
    func makeUIView(context: Context) -> WKWebView {

        let config = WKWebViewConfiguration()
        config.userContentController.add(context.coordinator, name: WebView.webMessage)
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator   // 웹의 탐색 동작을 관리하는데 사용하는 개체
        webView.allowsBackForwardNavigationGestures = true // 가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리거 하는지 여부
        webView.scrollView.isScrollEnabled = true          // 스크롤뷰에서 스크롤 가능 여부
        
        
        // 함수명을 적으면 됨
        let value = "valueFromView"
        webView.evaluateJavaScript("valueGotFromIOS(\(value))") { result, error in // evaluateJavaScript를 통해 웹 페이지의 자바스크립트 함수를 호출
            if let error = error {
                print("Error Calling from JS function: \(error)")
            } else if let result = result {
                print("Received result from JS function: \(result)")
            }
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if urlType == .localUrl {
            if let url = Bundle.main.url(forResource: "LocalWebsite", withExtension: "html", subdirectory: "www") {
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
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        
        private let parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // MARK: WKScriptMessageHandler
        // Receive value from web (iOS -> JS)
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == webMessage { // ios에서 메시지 핸들러를 추가할 때 지정한 이름 (fromWebPage)
                if let body = message.body as? [String: Any?] {
                    print("JSON received from web: \(body)")
                } else if let body = message.body as? String {
                    print("String received from web: \(body)")
                }
            }
        }
        
        
        // MARK: WKNavigationDelegate
        
        // navigationAction
        // 1. 처음에 action으로 요청할때 해당 navigation request를 허용하거나 거부
//        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//            print("1. ")
//        }
//        
//        // 2. 1번에서 decisionHandler(.allow)로 허가 났으면 navigation 시작
//        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            print("2. ")
//        }
//        
//        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
//            print("3. ")
//        }
//        
//        // pass value to web (JS -> iOS)
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            
//            // 1.
//            webView.evaluateJavaScript("document.title") { response, error in
//                guard let error = error else {
//                    print("error getting title")
//                    return
//                }
//                guard let title = response as? String else {
//                    return
//                }
//                parent.
//            }
//            
//            
//            let javascriptFunction = "valueFromIOS"
//            // page loaded so no need to show loader anymore
//            webView.evaluateJavaScript("", completionHandler: <#T##((Any?, Error?) -> Void)?##((Any?, Error?) -> Void)?##(Any?, Error?) -> Void#>)
//        }
        
    }
}
