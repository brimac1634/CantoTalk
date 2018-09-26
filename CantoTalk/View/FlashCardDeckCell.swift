//
//  FlashCardDeckCell.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 26/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class FlashCardDeckCell: BaseCell {
    
    
    let deckImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "CantoTalkIconCircle"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let deckTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Home"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        
        addSubview(deckImage)
        addSubview(deckTitle)
        
        NSLayoutConstraint.activate([
            
            ])
        
    }
}
