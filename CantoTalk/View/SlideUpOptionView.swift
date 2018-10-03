//
//  SlideUpOptionView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 3/10/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class SlideUpOptionView: MenuBar {
    
    
    override func setupViews() {
        collectionView.register(SlideUpOptionCells.self, forCellWithReuseIdentifier: cellID)
    }
    
    //MARK: - CollectionView Methods
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 30)
    }
}

class SlideUpOptionCells: BaseCell {
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.cantoDarkBlue(a: 1)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.cantoWhite(a: 1)
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
    
    }
}
