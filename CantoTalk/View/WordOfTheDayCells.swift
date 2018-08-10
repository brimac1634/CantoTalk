//
//  WordOfTheDayCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 10/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class WordOfTheDayCells: BaseCell {
    
    let entryView: EntryView = {
        let view = EntryView()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        return view
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(entryView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: entryView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: entryView)
    }
}
