//
//  GameListViewController.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation
import UIKit
import WebKit

final class GameListViewController: WebViewViewController {
    
    private static let gameNumberIndicatorMargin: CGFloat = 20.0
    private static let gameNumberIndicatorHeight: CGFloat = 20.0
    
    private static let modelParsingErrorTitle = "Error!"
    private static let modelParsingErrorMessage = "Parsing data error, please contact customer support ;)"
    private static let modelParsingErrorButtonTitle = "OK"
    
    private static let webViewConnectionErrorTitle = "Error!"
    private static let webViewConnectionErrorMessage = "Resource could not be loaded"
    
    private static let titleRemovalScript = """
                var elem = document.getElementsByTagName(\"h3\")[0];
                var result = elem.innerText
                elem.parentNode.removeChild(elem);
                result
    """
    
    private let viewModel: GameListViewModel
    private let gameNumberIndicator = GameNumberIndicator()
    private var navigationBarShouldBeHidden = false
    
    init(viewModel: GameListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(navigationBarShouldBeHidden, animated: false)
    }
    
    private func setupWebView() {
        configureWebView(with: viewModel.messageHandlers,
                         url: viewModel.listDataURL) { [weak self] message in
            
            message?.forEach({ (key: String, value: AnyObject) in
                guard let id = MessageReceiverId(rawValue: key) else { return }
                self?.handle(id, message: value)
            })
        }
        
        webView.navigationDelegate = self
    }
}

// MARK: Nav view handing

extension GameListViewController {
    
    private func setupNavigationBarVisible(with title: String?) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        gameNumberIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameNumberIndicator.heightAnchor.constraint(equalToConstant: Self.gameNumberIndicatorHeight)
        ])
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.gameNumberIndicator)
        self.title = title
        
        navigationBarShouldBeHidden = false
    }
    
    private func setupNavigationBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        gameNumberIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(gameNumberIndicator)
        NSLayoutConstraint.activate([
            gameNumberIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Self.gameNumberIndicatorMargin),
            gameNumberIndicator.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            gameNumberIndicator.heightAnchor.constraint(equalToConstant: Self.gameNumberIndicatorHeight)
        ])
        
        navigationBarShouldBeHidden = true
    }
}

// MARK: Data handling

extension GameListViewController {
    
    private func handle(_ id: MessageReceiverId, message: AnyObject) {
        switch id {
        case .gameSelected:
            do {
                let model = try viewModel.decode(type: GameModel.self, from: message)
                route(to: .gameDetail(model: model))
            } catch {
                handleModelParsingError()
            }
        case .gamesLoaded:
            do {
                let count = try viewModel.decode(type: Int.self, from: message)
                gameNumberIndicator.gameNumber = count
            } catch {
                handleModelParsingError()
            }
        }
    }
    
    private func handleModelParsingError() {
        let alert = UIAlertController(title: Self.modelParsingErrorTitle, message: Self.modelParsingErrorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Self.modelParsingErrorButtonTitle, style: .destructive, handler: nil))
        present(alert, animated: true)
    }
    
    private func handleWebViewConnectionError() {
        let alert = UIAlertController(title: Self.webViewConnectionErrorTitle, message: Self.webViewConnectionErrorMessage, preferredStyle: .alert)
        present(alert, animated: true)
    }
}

// MARK: WKNavigationDelegate

extension GameListViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        /**
        Discussion:
        Since embedded web page already contains "List of Games" title, adding native navigation bar with doubled title doesnt' make sense.
        Instead of that, native iOS app tries to remove html title first and then sets native navigation bar with proper title and number indicator view on the right.
        If removal fails, navigation bar would be hidden and number indicator pinned to right side on the screen.

        Project description is inconclusive in that matter ;)
        */

        webView.evaluateJavaScript(Self.titleRemovalScript) { [weak self] result, error in
            guard let self = self else { return }
            guard let result = result as? String else {
                self.setupNavigationBarHidden()
                return
            }
             
            self.setupNavigationBarVisible(with: result)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        handleWebViewConnectionError()
    }
}
