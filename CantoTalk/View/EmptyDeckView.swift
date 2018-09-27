////
////  EmptyDeckView.swift
////  CantoTalk
////
////  Created by Brian MacPherson on 27/9/2018.
////  Copyright © 2018 Brian MacPherson. All rights reserved.
////
//
//import UIKit
//
//class EmptyDeckView: BaseView {
//    
//    let emptyCard: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.orange
//        return view
//    }()
//    
//    let image: UIImageView = {
//        let image = UIImageView(image: UIImage(named: "add"))
//        image.contentMode = .scaleAspectFit
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
//    
//    let label: UILabel = {
//        let label = UILabel()
//        label.text = "Create new deck"
//        label.textColor = UIColor.cantoDarkBlue(a: 1)
//        label.font = UIFont.systemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    override func setupViews() {
//        addSubview(emptyCard)
//        emptyCard.addSubview(image)
//        addSubview(label)
//        
//        NSLayoutConstraint.activate([
//            label.bottomAnchor.constraint(equalTo: bottomAnchor),
//            label.widthAnchor.constraint(equalTo: widthAnchor),
//            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
//            
//            emptyCard.centerXAnchor.constraint(equalTo: centerXAnchor),
//            emptyCard.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
//            emptyCard.heightAnchor.constraint(equalTo: <#T##NSLayoutDimension#>, multiplier: <#T##CGFloat#>)
//            
//        
//            
//            card.centerXAnchor.constraint(equalTo: centerXAnchor),
//            card.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
//            card.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
//            card.bottomAnchor.constraint(equalTo: deckTitle.topAnchor),
//            
//            deckImage.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.6),
//            deckImage.heightAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.6),
//            deckImage.centerXAnchor.constraint(equalTo: card.centerXAnchor),
//            deckImage.centerYAnchor.constraint(equalTo: card.centerYAnchor)
//            ])
//        
//    }
//    
//    
//    
//}
