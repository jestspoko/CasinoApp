//
//  Routable.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation

protocol Routable {
    var router: Router? { get }
    func route(to view: View)
}

extension Routable {
    func route(to view: View) {
        guard let router = router else {
            assertionFailure("Router should be initialized.")
            return
        }
        
        router.route(to: view)
    }
}
