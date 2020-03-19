//
//  ViewController.swift
//  Concentration
//
//  Created by Matheus Henrick Dias on 25/02/20.
//  Copyright © 2020 Matheus Henrick Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count+1)/2   //computed property(simples, não precisa do get)
    }
    
    private(set) var flipCount = 0{
        didSet {
           updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes:  attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        } 
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount+=1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card is not on cardButtons")
        }
            
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFacedUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    //private var emojiChoices = ["🦇","😱","🎃","👻","😈","🤡","👹","💀","🙀"]
    private var emojiChoices = "🦇😱🎃👻😈🤡👹💀🙀"

    private var emoji = [Card:String]()// dictionary
    
    private  func emoji(for card: Card) -> String{
        if emoji[card] == nil , emojiChoices.count > 0 { // dois if um dentro do outro separados com ","
            //let x = 5.arc4random
            //let randomIndex = Int (arc4random_uniform(UInt32(emojiChoices.count)))
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            
        }
        return emoji[card] ?? "?"
    }
}
    extension Int {
        var arc4random: Int {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
            }else if self < 0 {
                return -Int(arc4random_uniform(UInt32(abs(self))))
            } else {
                return 0
            }
        }
    }
    
    


