//
//  GameDetailViewModel.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation

final class GameDetailViewModel {
    private var model: GameModel
    
    init(model: GameModel) {
        self.model = model
    }
    
    var gameName: String {
        model.name
    }
    
    var colorTheme: String {
        model.theme
    }
    
    var gameDescription: String {
        model.description
    }
}
