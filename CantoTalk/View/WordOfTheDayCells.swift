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
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(entryView)
        
        NSLayoutConstraint.activate([
            entryView.topAnchor.constraint(equalTo: topAnchor),
            entryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            entryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            entryView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: entryView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: entryView)
    }
}
