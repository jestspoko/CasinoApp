//
//  GameListViewModel.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation

enum MessageReceiverId: String {
    case gameSelected = "gameSelected"
    case gamesLoaded = "gamesLoaded"
}

final class GameListViewModel {

    var messageHandlers: [MessageReceiverId] {
        [.gameSelected, .gamesLoaded]
    }
    var listDataURL: URL {
        URL(string: "http://localhost:3000/")!
    }
    
    func decode<A>(type: A.Type, from data:AnyObject) throws -> A where A: Decodable {
        
        if let result = data as? A {
            return result
        }
        
        return try JSONDecoder().decode(A.self, from: try JSONSerialization.data(withJSONObject: data))
    }
}
