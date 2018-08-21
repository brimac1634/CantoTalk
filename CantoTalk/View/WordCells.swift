//
//  WordCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class WordCells: BaseCell {
    
    var selectedEntry: Entries? {
        didSet {
            if let entry = selectedEntry {
                cantoWordLabel.text = entry.cantoWord
                classifierLabel.text = entry.classifier
                jyutpingLabel.text = entry.jyutping
                wordTypeLabel.text = entry.wordType
                englishWordLabel.text = "En: \(entry.englishWord)"
                mandarinWordLabel.text = "普: \(entry.mandarinWord)"
            }
        }
    }

//    let leftContainer: UIView = {
//        let view = UIView()
//    }
    let cantoWordLabel: UILabel = {
        let label = UILabel()
        label.text = "單車"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let classifierLabel: UILabel = {
        let label = UILabel()
        label.text = "(cl:架 ga3)"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let englishWordLabel: UILabel = {
        let label = UILabel()
        label.text = "En: bicycle"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.numberOfLines = 1
        return label
    }()
    
    let mandarinWordLabel: UILabel = {
        let label = UILabel()
        label.text = "普: 自行車"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.numberOfLines = 1
        return label
    }()
    
    let jyutpingLabel: UILabel = {
        let label = UILabel()
        label.text = "daan1 che1"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wordTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "noun"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoLightBlue(a: 1)
        return label
    }()
    
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   let halfCellWidth = UIScreen.main.bounds.width / 2
    
    override func setupViews() {
        
        
        
        addSubview(cantoWordLabel)
        addSubview(classifierLabel)
        addSubview(jyutpingLabel)
        addSubview(englishWordLabel)
        addSubview(mandarinWordLabel)
        addSubview(wordTypeLabel)
        addSubview(separatorView)
        
        
        


        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)

        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(80)]", views: cantoWordLabel, classifierLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(80)]", views: jyutpingLabel, wordTypeLabel)
        addConstraintsWithFormat(format: "H:|-\(halfCellWidth)-[v0]-16-|", views: englishWordLabel)
        addConstraintsWithFormat(format: "H:|-\(halfCellWidth)-[v0]-16-|", views: mandarinWordLabel)
        
        addConstraintsWithFormat(format: "V:|-16-[v0(25)]-8-[v1(25)]-15-[v2(1)]", views: cantoWordLabel, jyutpingLabel, separatorView)
        addConstraintsWithFormat(format: "V:|-16-[v0(25)]-8-[v1(25)]-16-|", views: classifierLabel, wordTypeLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0(25)]-8-[v1(25)]-16-|", views: englishWordLabel, mandarinWordLabel)

        
        
        
    }
   
}

















