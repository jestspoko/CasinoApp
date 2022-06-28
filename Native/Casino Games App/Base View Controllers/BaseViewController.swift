//
//  BaseViewController.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, Routable {
    var router: Router?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

