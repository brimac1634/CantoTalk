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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let trailingDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
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
        backgroundColor = UIColor.cantoDarkBlue(a: 1)
        
        addSubview(dividerView)
        addSubview(cellView)
        addSubview(trailingDividerView)
        cellView.addSubview(dateText)
        cellView.addSubview(entryView)
        
        NSLayoutConstraint.activate([
            
            dividerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.widthAnchor.constraint(equalToConstant: 8),
            
            trailingDividerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            trailingDividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trailingDividerView.widthAnchor.constraint(equalToConstant: 8),
            
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cellView.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor),
            cellView.trailingAnchor.constraint(equalTo: trailingDividerView.leadingAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
            
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
