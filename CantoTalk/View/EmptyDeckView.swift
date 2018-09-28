//
//  EmptyDeckView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 27/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class EmptyDeckView: UIButton {
    
    let emptyCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "add"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Create new deck"
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emptyCard)
        emptyCard.addSubview(image)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            emptyCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyCard.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            emptyCard.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            emptyCard.bottomAnchor.constraint(equalTo: label.topAnchor),
            
            image.widthAnchor.constraint(equalTo: emptyCard.widthAnchor, multiplier: 0.4),
            image.heightAnchor.constraint(equalTo: emptyCard.widthAnchor, multiplier: 0.4),
            image.centerXAnchor.constraint(equalTo: emptyCard.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: emptyCard.centerYAnchor)
            ])
        
    }  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
