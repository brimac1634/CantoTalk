//
//  WordOfTheDayCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 2/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class WordOfTheDayCells: BaseCell {
    
    let entryView: EntryView = {
        let view = EntryView()
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "August 3rd 2018"
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override func setupViews() {
        
        addSubview(entryView)
        addSubview(dateLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: entryView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: dateLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0(30)]-16-[v1]|", views: dateLabel, entryView)
        
//        addConstraintsWithFormat(format: "V:|[v0(30)]", views: dateLabel)
        
    }
}
