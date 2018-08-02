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
    

    let cantoWordLabel: UILabel = {
        let label = UILabel()
        label.text = "單車"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let classifierLabel: UITextView = {
        let tV = UITextView()
        tV.text = "(架 ga3)"
        tV.backgroundColor = UIColor.cantoWhite(a: 1)
        tV.textColor = UIColor.cantoDarkBlue(a: 1)
        return tV
    }()
    
    let englishWordLabel: UILabel = {
        let label = UILabel()
        label.text = "bicycle"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.numberOfLines = 3
        return label
    }()
    
    let jyutpingLabel: UILabel = {
        let label = UILabel()
        label.text = "daan1 che1"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.cantoDarkBlue(a: 0.8)
        return label
    }()
    
    let wordTypeLabel: UITextView = {
        let tV = UITextView()
        tV.text = "noun"
        tV.backgroundColor = UIColor.cantoWhite(a: 1)
        tV.textColor = UIColor.cantoLightBlue(a: 0.8)
        return tV
    }()
    
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 0.5)
        return view
    }()
    
   let halfCellWidth = UIScreen.main.bounds.width / 2
    
    override func setupViews() {
        
        
        
        addSubview(cantoWordLabel)
        addSubview(classifierLabel)
        addSubview(jyutpingLabel)
        addSubview(englishWordLabel)
        addSubview(wordTypeLabel)
        addSubview(separatorView)


        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)

        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(80)]", views: cantoWordLabel, classifierLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(80)]", views: jyutpingLabel, wordTypeLabel)
        addConstraintsWithFormat(format: "H:|-\(halfCellWidth)-[v0]-16-|", views: englishWordLabel)
        
        addConstraintsWithFormat(format: "V:|-16-[v0(25)]-8-[v1(25)]-15-[v2(1)]", views: cantoWordLabel, jyutpingLabel, separatorView)
        addConstraintsWithFormat(format: "V:|-16-[v0(25)]-8-[v1(25)]-16-|", views: classifierLabel, wordTypeLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-17-|", views: englishWordLabel)

        
        
        
    }
   
}

















