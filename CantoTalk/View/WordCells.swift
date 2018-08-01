//
//  WordCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WordCells: BaseCell {
    

    let cantoWord: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        return label
    }()
    
   
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(cantoWord)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: cantoWord)
        addConstraintsWithFormat(format: "V:|[v0(18)]", views: cantoWord)
        
        
    }
    

    
    
    
}

















