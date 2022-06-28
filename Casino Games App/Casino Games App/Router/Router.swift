//
//  Router.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation
import UIKit

final class Router {
    
    enum PresentationMode {
        case modal
        case push
    }
    
    private var navigationViewController: UINavigationController?
    
    func route(to view: View, presentationMode: PresentationMode = .push) {
        present(with: presentationMode, viewController: getViewController(for: view))
    }
    
    func routeBack() {
        navigationViewController?.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationViewController?.dismiss(animated: true)
    }
    
    func initializeWithRoot(for view: View) -> UIViewController? {
        guard navigationViewController == nil else {
            assertionFailure("Router initialized already.")
            return nil
        }
        navigationViewController = UINavigationController()
        let vc = getViewController(for: view)
        navigationViewController?.viewControllers = [vc]
        return navigationViewController
    }
    
    private func getViewController(for view: View) -> UIViewController {
        let vc: BaseViewController
        switch view {
        case .gameList:
            vc = GameListViewController(viewModel: GameListViewModel())
        case .gameDetail(model: let model):
            vc = GameDetailViewController(viewModel: GameDetailViewModel(model: model))
        }
        vc.router = self
        return vc
    }
    
    private func present(with presentationMode: PresentationMode, viewController: UIViewController) {
        switch presentationMode {
        case .modal:
            navigationViewController?.present(viewController, animated: true)
        case .push:
            navigationViewController?.pushViewController(viewController, animated: true)
        }
    }
}
