//
//  EntryView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 1/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class EntryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let favoritesRealm = try! Realm()
    let selectedHeartColor = UIColor.cantoPink(a: 1)
    let unselectedHeartColor = UIColor.cantoLightBlue(a: 1)
    var isFavorited: Bool?
    var currentEntry: Entries?
    
    
    
    var selectedEntry: Entries? {
        didSet {
            if let entry = selectedEntry {
                
                
                cantoWordLabel.text = entry.cantoWord
                classifierLabel.text = entry.classifier
                jyutpingLabel.text = entry.jyutping
                wordTypeLabel.text = entry.wordType
                englishWordLabel.text = "En: \(entry.englishWord)"
                mandarinWordLabel.text = "普: \(entry.mandarinWord)"
                cantoSentence.text = entry.cantoSentence
                jyutpingSentence.text = entry.jyutpingSentence
                englishSentence.text = entry.englishSentence
                
                currentEntry = favoritesRealm.objects(Entries.self).filter("cantoWord = '\(entry.cantoWord)'").first
                print(Realm.Configuration.defaultConfiguration.fileURL)
                if currentEntry != nil {
                    isFavorited = true
                    heartButton.tintColor = selectedHeartColor
                } else {
                    isFavorited = false
                    heartButton.tintColor = unselectedHeartColor
                }

            }
        }
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
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let englishWordLabel: UILabel = {
        let label = UILabel()
        label.text = "En: bicycle"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.numberOfLines = 2
        return label
    }()
    
    let mandarinWordLabel: UILabel = {
        let label = UILabel()
        label.text = "普: 自行車"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.numberOfLines = 2
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
        label.textColor = UIColor.cantoLightBlue(a: 1)
        return label
    }()
    
    let cantoSentence: UILabel = {
        let label = UILabel()
        label.text = "我哋想租兩架單車"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let jyutpingSentence: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let englishSentence: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let heartButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.cantoLightBlue(a: 1)
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return button
    }()
    
    @objc func handleFavorite() {
        if isFavorited == false {
            try! favoritesRealm.write {
                if let entry = selectedEntry {
                    let newFavorite = Entries()
                    newFavorite.cantoWord = entry.cantoWord
                    newFavorite.classifier = entry.classifier
                    newFavorite.jyutping = entry.jyutping
                    newFavorite.wordType = entry.wordType
                    newFavorite.englishWord = entry.englishWord
                    newFavorite.mandarinWord = entry.mandarinWord
                    newFavorite.cantoSentence = entry.cantoSentence
                    newFavorite.jyutpingSentence = entry.jyutpingSentence
                    newFavorite.englishSentence = entry.englishSentence
                    newFavorite.dateFavorited = Date()
                    favoritesRealm.add(newFavorite)
                    currentEntry = newFavorite
                    
                }
            }
            isFavorited = true
            heartButton.tintColor = selectedHeartColor
            
        } else {
            try! favoritesRealm.write {
                if let entry = currentEntry {
                    favoritesRealm.delete(entry)
                }
            }
            isFavorited = false
            heartButton.tintColor = unselectedHeartColor

        }
        
        
        
    }
    
    
    func setupView() {
        
        addSubview(cantoWordLabel)
        addSubview(classifierLabel)
        addSubview(jyutpingLabel)
        addSubview(englishWordLabel)
        addSubview(mandarinWordLabel)
        addSubview(wordTypeLabel)
        addSubview(cantoSentence)
        addSubview(jyutpingSentence)
        addSubview(englishSentence)
        addSubview(heartButton)
        
        addConstraintsWithFormat(format: "H:|-32-[v0]-8-[v1(80)]", views: cantoWordLabel, classifierLabel)
        addConstraintsWithFormat(format: "H:|-32-[v0]-8-[v1(80)]", views: jyutpingLabel,wordTypeLabel)
        addConstraintsWithFormat(format: "H:|-32-[v0]", views: englishWordLabel)
        addConstraintsWithFormat(format: "H:|-32-[v0]", views: mandarinWordLabel)
        addConstraintsWithFormat(format: "H:|-32-[v0]", views: cantoSentence)
        addConstraintsWithFormat(format: "H:|-32-[v0]", views: jyutpingSentence)
        addConstraintsWithFormat(format: "H:|-32-[v0]", views: englishSentence)
        
        addConstraintsWithFormat(format: "V:|-32-[v0(30)]-8-[v1(30)]-48-[v2(30)]-8-[v3(30)]-48-[v4(30)]-8-[v5(30)]-8-[v6(30)]", views: cantoWordLabel, jyutpingLabel, englishWordLabel, mandarinWordLabel, cantoSentence, jyutpingSentence, englishSentence)
        addConstraintsWithFormat(format: "V:|-32-[v0(30)]-8-[v1(30)]", views: classifierLabel, wordTypeLabel)
        
        addConstraintsWithFormat(format: "H:[v0]-32-|", views: heartButton)
        addConstraintsWithFormat(format: "V:[v0]-32-|", views: heartButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
