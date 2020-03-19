//
//  Concentration.swift
//  Concentration
//
//  Created by Matheus Henrick Dias on 26/02/20.
//  Copyright © 2020 Matheus Henrick Dias. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOnlyFaceUpCard: Int? { //computed properties
        get {
            return cards.indices.filter{cards[$0].isFacedUp}.oneAndOnly
            /* var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFacedUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex */
        }
        set {
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
            } else {
                indexOfOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        
    }   
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
