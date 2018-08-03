//
//  EntryView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 1/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class EntryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let cantoWordLabel: UILabel = {
        let label = UILabel()
        label.text = "單車"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let classifierLabel: UILabel = {
        let label = UILabel()
        label.text = "(架 ga3)"
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let englishWordLabel: UILabel = {
        let label = UILabel()
        label.text = "bicycle"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.numberOfLines = 3
        return label
    }()
    
    let jyutpingLabel: UILabel = {
        let label = UILabel()
        label.text = "daan1 che1"
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.cantoLightBlue(a: 1)
        return label
    }()
    
    let wordTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "noun"
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoLightBlue(a: 1)
        return label
    }()
    
    let cantoSentence: UILabel = {
        let label = UILabel()
        label.text = "我哋想租兩架單車"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let heartButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.cantoLightBlue(a: 1)
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)

        return button
    }()
    
    @objc func handleFavorite() {
        print(123)
    }
    
    
    func setupView() {
        
        addSubview(cantoWordLabel)
        addSubview(classifierLabel)
        addSubview(jyutpingLabel)
        addSubview(englishWordLabel)
        addSubview(wordTypeLabel)
        addSubview(cantoSentence)
        addSubview(heartButton)
        
        addConstraintsWithFormat(format: "H:|-32-[v0]-8-[v1(80)]", views: cantoWordLabel, classifierLabel)
        addConstraintsWithFormat(format: "H:|-32-[v0]-8-[v1(80)]", views: jyutpingLabel,wordTypeLabel)
        addConstraintsWithFormat(format: "H:|-32-[v0]", views: englishWordLabel)
        addConstraintsWithFormat(format: "H:|-32-[v0]", views: cantoSentence)
        
        addConstraintsWithFormat(format: "V:|-32-[v0(30)]-16-[v1(30)]-48-[v2(30)]-48-[v3(30)]", views: cantoWordLabel, jyutpingLabel, englishWordLabel, cantoSentence)
        addConstraintsWithFormat(format: "V:|-32-[v0(30)]-16-[v1(30)]", views: classifierLabel, wordTypeLabel)
        
        addConstraintsWithFormat(format: "H:[v0]-32-|", views: heartButton)
        addConstraintsWithFormat(format: "V:[v0]-32-|", views: heartButton)
           
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
