//
//  Card.swift
//  Concentration
//
//  Created by Matheus Henrick Dias on 26/02/20.
//  Copyright © 2020 Matheus Henrick Dias. All rights reserved.
//

import Foundation
struct Card {
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
