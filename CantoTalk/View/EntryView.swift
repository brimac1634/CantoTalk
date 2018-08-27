//
//  EntryView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 1/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class EntryView: BaseView {

    
    override func setupViews() {
        super.setupViews()
        setupView()
    }


    let userRealm = try! Realm()
    var favoritesController: FavoritesController?
    let selectedHeartColor = UIColor.cantoPink(a: 1)
    let unselectedHeartColor = UIColor.cantoLightBlue(a: 1)
    var isFavorited: Bool?
    var currentEntry: Entries?

    var selectedEntry: Entries? {
        didSet {
            guard let entry = selectedEntry else {return}
            let topText = NSMutableAttributedString(string: entry.cantoWord, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)])
            if entry.classifier != "" {
                topText.append(NSAttributedString(string: " (cl:\(entry.classifier))", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            }
            topText.append(NSAttributedString(string: "\n\(entry.jyutping)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            
            
            cantoWordLabel.attributedText = topText
            
            let englishWordText = NSMutableAttributedString(string: "En: ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.cantoLightBlue(a: 0.8)])
            englishWordText.append(NSAttributedString(string: entry.englishWord, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            englishWordLabel.attributedText = englishWordText
            
            let mandarinWordText = NSMutableAttributedString(string: "普: ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.cantoLightBlue(a: 0.8)])
            mandarinWordText.append(NSAttributedString(string: entry.mandarinWord, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            mandarinWordLabel.attributedText = mandarinWordText
            
            let sentenceText = NSMutableAttributedString(string: "\(entry.cantoSentence)\n\(entry.jyutpingSentence)\n\(entry.englishSentence)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)])
            sentenceLabel.attributedText = sentenceText
            
            
            currentEntry = userRealm.objects(Entries.self).filter("entryID = \(String(entry.entryID))").first
            if currentEntry != nil {
                isFavorited = true
                heartButton.tintColor = selectedHeartColor
            } else {
                isFavorited = false
                heartButton.tintColor = unselectedHeartColor
            }
        }
    }
    

    let cantoWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let englishWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let mandarinWordLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()

    let sentenceLabel: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    let heartButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "heart_solid")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return button
    }()

    @objc func handleFavorite() {
        if isFavorited == false {
            try! userRealm.write {
                if let entry = selectedEntry {
                    let newFavorite = Entries()
                    newFavorite.entryID = entry.entryID
                    newFavorite.cantoWord = entry.cantoWord
                    newFavorite.classifier = entry.classifier
                    newFavorite.jyutping = entry.jyutping
                    newFavorite.englishWord = entry.englishWord
                    newFavorite.mandarinWord = entry.mandarinWord
                    newFavorite.cantoSentence = entry.cantoSentence
                    newFavorite.jyutpingSentence = entry.jyutpingSentence
                    newFavorite.englishSentence = entry.englishSentence
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = formatter.string(from: Date())
                    newFavorite.dateFavorited = date
                    userRealm.add(newFavorite)
                    currentEntry = newFavorite

                }
            }
            isFavorited = true
            heartButton.tintColor = selectedHeartColor
            favoritesController?.loadData()


        } else {
            try! userRealm.write {
                if let entry = currentEntry {
                    userRealm.delete(entry)
                }
            }
            isFavorited = false
            heartButton.tintColor = unselectedHeartColor
            favoritesController?.loadData()
        }
    }
    
    


    func setupView() {

        let middleStackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [englishWordLabel, mandarinWordLabel])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 8
            return stack
        }()
        
        addSubview(heartButton)
        addSubview(cantoWordLabel)
        addSubview(middleStackView)
        addSubview(sentenceLabel)
        
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            heartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            heartButton.widthAnchor.constraint(equalToConstant: 50),
            heartButton.heightAnchor.constraint(equalToConstant: 50),
            
            cantoWordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            cantoWordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            cantoWordLabel.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -8),
            cantoWordLabel.heightAnchor.constraint(equalToConstant: 140),
            
            middleStackView.topAnchor.constraint(equalTo: cantoWordLabel.bottomAnchor, constant: 16),
            middleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            middleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            middleStackView.heightAnchor.constraint(equalToConstant: 80),
            
            sentenceLabel.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: 16),
            sentenceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            sentenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            sentenceLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32)
            ])

        

    }

}
