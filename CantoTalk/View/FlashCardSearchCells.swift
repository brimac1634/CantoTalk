//
//  flashCardSearchCell.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 2/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class FlashCardSearchCells: WordCells {
    
    let cellStackTrailingDistance: CGFloat = -45

    
    let checkMarkView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "checkMark")?.withRenderingMode(.alwaysTemplate))
        view.tintColor = UIColor.cantoDarkBlue(a: 1)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(checkMarkView)
        
        cellStackViewTrailingConstraint.constant = cellStackTrailingDistance
        
        NSLayoutConstraint.activate([
            checkMarkView.widthAnchor.constraint(equalToConstant: 34),
            checkMarkView.heightAnchor.constraint(equalToConstant: 34),
            checkMarkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkMarkView.centerXAnchor.constraint(equalTo: trailingAnchor, constant: cellStackTrailingDistance / 2)
            ])
        
        checkMarkView.alpha = 0
    }
    
    func selected() {
        checkMarkView.alpha = 1
        backgroundColor = UIColor.lightGray
        cantoWordLabel.backgroundColor = UIColor.lightGray
        jyutpingLabel.backgroundColor = UIColor.lightGray
        englishWordLabel.backgroundColor = UIColor.lightGray
        mandarinWordLabel.backgroundColor = UIColor.lightGray
    }
    
    func unselected() {
        checkMarkView.alpha = 0
        backgroundColor = UIColor.cantoWhite(a: 1)
        cantoWordLabel.backgroundColor = UIColor.cantoWhite(a: 1)
        jyutpingLabel.backgroundColor = UIColor.cantoWhite(a: 1)
        englishWordLabel.backgroundColor = UIColor.cantoWhite(a: 1)
        mandarinWordLabel.backgroundColor = UIColor.cantoWhite(a: 1)
    }
}
