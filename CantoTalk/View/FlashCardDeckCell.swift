//
//  FlashCardDeckCell.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 26/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class FlashCardDeckCell: BaseCell {
    
    var cardDeck: FlashCardDeck? {
        didSet {
            guard let deck = cardDeck else {return}
            deckTitle.text = deck.deckTitle
        }
    }
    
    let deckImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "CantoTalkIconCircle"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.alpha = 0.3
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let deckTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Home"
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        
        addSubview(deckImage)
        addSubview(deckTitle)
        
        NSLayoutConstraint.activate([
            
            deckTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            deckTitle.widthAnchor.constraint(equalTo: widthAnchor),
            deckTitle.heightAnchor.constraint(equalToConstant: 20),
            
            deckImage.widthAnchor.constraint(equalTo: widthAnchor),
            deckImage.topAnchor.constraint(equalTo: topAnchor),
            deckImage.bottomAnchor.constraint(equalTo: deckTitle.topAnchor)
            ])
        
    }
}
