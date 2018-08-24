//
//  WordOfTheDayCells.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 10/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class WordOfTheDayCells: BaseCell {
    
    let cellView: UIView = {
        let view = UIView()
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
    
    let dateText: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let entryView: EntryView = {
        let view = EntryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(cellView)
        cellView.addSubview(dateText)
        cellView.addSubview(entryView)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dateText.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            dateText.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            dateText.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            dateText.heightAnchor.constraint(equalToConstant: 35),
            
            entryView.topAnchor.constraint(equalTo: dateText.bottomAnchor),
            entryView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            entryView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            entryView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)

            ])
        
    }
}
