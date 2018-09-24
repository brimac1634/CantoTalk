//
//  InfoView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 19/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class KeyCell: BaseTableViewCell {
    
    var pronounciationKey: PronounciationKey? {
        didSet {
            guard let key = pronounciationKey else {return}
            keyLabel.text = key.keyWord
            
            var text = key.exampleJyutping
            text.append("    \(key.exampleCanto)")
            exampleLabel.text = text
            
            speakerButton.spokenWord = key.exampleCanto
            
            englishLabel.text = key.englishWord
        }
    }
    
    
    let keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let exampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()

    let speakerButton: SpeakerButton = {
        let button = SpeakerButton()
        button.normalColor = UIColor.cantoDarkBlue(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dividerView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let englishLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let bottomDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func setupViews() {
        
        backgroundColor = UIColor.cantoWhite(a: 1)
        
        addSubview(keyLabel)
        addSubview(dividerView)
        addSubview(exampleLabel)
        addSubview(speakerButton)
        addSubview(dividerView2)
        addSubview(englishLabel)
        addSubview(bottomDividerView)
        
        NSLayoutConstraint.activate([
            keyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            keyLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            keyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            dividerView.heightAnchor.constraint(equalTo: heightAnchor),
            dividerView.widthAnchor.constraint(equalToConstant: 1),
            dividerView.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor),
            
            englishLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            englishLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            englishLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            
            dividerView2.trailingAnchor.constraint(equalTo: englishLabel.leadingAnchor),
            dividerView2.widthAnchor.constraint(equalToConstant: 1),
            dividerView2.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            
            speakerButton.heightAnchor.constraint(equalToConstant: 40),
            speakerButton.widthAnchor.constraint(equalToConstant: 40),
            speakerButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            speakerButton.trailingAnchor.constraint(equalTo: dividerView2.leadingAnchor, constant: -16),
            
            exampleLabel.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor),
            exampleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            exampleLabel.trailingAnchor.constraint(equalTo: speakerButton.leadingAnchor, constant: -8),
            
            bottomDividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomDividerView.heightAnchor.constraint(equalToConstant: 1),
            bottomDividerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)

            ])
        
        
        speakerButton.setColor(color: UIColor.cantoDarkBlue(a: 1))
    }
    

}
