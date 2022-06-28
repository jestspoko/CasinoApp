//
//  GameModel.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation


struct GameModel: Decodable {
    var description: String
    var name: String
    var theme: String
}
