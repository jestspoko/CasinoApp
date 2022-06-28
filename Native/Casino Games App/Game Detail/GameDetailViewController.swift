//
//  GameDetailViewController.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation
import UIKit

final class GameDetailViewController: BaseViewController {
    
    private let viewModel: GameDetailViewModel
    
    init(viewModel: GameDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = viewModel.gameName
        
        let card = UITextView()
        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            card.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -40),
            card.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40)
        ])
        
        card.text = viewModel.gameDescription
        view.backgroundColor = UIColor.from(string: viewModel.colorTheme)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
