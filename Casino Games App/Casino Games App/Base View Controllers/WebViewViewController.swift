//
//  ViewController.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import UIKit
import WebKit

typealias MessageReceivedHandler = (_ message: [String: AnyObject]?) -> Void

class WebViewViewController: BaseViewController {

    private var messageReceivedHandler: MessageReceivedHandler?
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func configureWebView(with scriptMessageHandlerIds:[MessageReceiverId], url: URL, messageReceivedHandler: MessageReceivedHandler?) {
        self.messageReceivedHandler = messageReceivedHandler
        webView.load(URLRequest(url: url))
        scriptMessageHandlerIds.forEach { webView.configuration.userContentController.add(self, name: $0.rawValue) }
    }
    
    private func setup() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
    }
}

extension WebViewViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        messageReceivedHandler?(message.body as? [String: AnyObject])
    }
}

