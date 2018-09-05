//
//  EntryView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 1/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation

class EntryView: BaseView, AVSpeechSynthesizerDelegate {

    let userRealm = try! Realm()
    let speaker = AVSpeechSynthesizer()
    var favoritesController: FavoritesController?
    let selectedHeartColor = UIColor.cantoPink(a: 1)
    let unselectedHeartColor = UIColor.cantoLightBlue(a: 1)
    var isFavorited: Bool?
    var currentEntry: Favorites?
    var cantoWordString: String?
    
    override func setupViews() {
        super.setupViews()
        setupView()
        speaker.delegate = self
    }

    
    

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
            
            
            currentEntry = userRealm.objects(Favorites.self).filter("entryID = \(String(entry.entryID))").first
            if currentEntry != nil {
                isFavorited = true
                heartButton.isSelected = true
                heartButton.tintColor = selectedHeartColor
            } else {
                isFavorited = false
                heartButton.isSelected = false
                heartButton.tintColor = unselectedHeartColor
            }
            
            cantoWordString = entry.cantoWord
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

    let speakerButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "speaker")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.cantoDarkBlue(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSpeaker), for: .touchUpInside)
        return button
    }()

    let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate)
        let favoritedImage = UIImage(named: "heart_solid")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(favoritedImage, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return button
    }()
    
    let heartButtonTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cantoLightBlue(a: 0.8)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func handleSpeaker() {
        if speaker.isSpeaking {
            speaker.stopSpeaking(at: .immediate)
            speakerButton.tintColor = UIColor.cantoDarkBlue(a: 1)
        } else {
            speakerButton.tintColor = UIColor.cantoPink(a: 1)
            let audioSession = AVAudioSession.sharedInstance()
            try? audioSession.setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
            
            guard let cantoWord = cantoWordString else {return}
            let voice = AVSpeechSynthesisVoice(language: "zh-HK")
            let context = AVSpeechUtterance(string: cantoWord)
            context.voice = voice
            print(cantoWord)
            speaker.speak(context)
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speakerButton.tintColor = UIColor.cantoDarkBlue(a: 1)
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setActive(false)
    }

    @objc func handleFavorite() {
        if isFavorited == false {
            try! userRealm.write {
                if let entry = selectedEntry {
                    let newFavorite = Favorites()
                    newFavorite.entryID = entry.entryID
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = formatter.string(from: Date())
                    newFavorite.dateFavorited = date
                    userRealm.add(newFavorite)
                    currentEntry = newFavorite

                }
            }
            isFavorited = true
            heartButton.isSelected = true
            heartButton.tintColor = selectedHeartColor
            heartButtonTitle.text = "Liked"
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.heartButtonTitle.alpha = 1
            }) { (Bool) in
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                    self.heartButtonTitle.alpha = 0
                }, completion: nil)
            }
            favoritesController?.loadData()


        } else {
            try! userRealm.write {
                if let entry = currentEntry {
                    userRealm.delete(entry)
                }
            }
            isFavorited = false
            heartButton.isSelected = false
            heartButton.tintColor = unselectedHeartColor
            heartButtonTitle.text = "Unliked"
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.heartButtonTitle.alpha = 1
            }) { (Bool) in
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                    self.heartButtonTitle.alpha = 0
                }, completion: nil)
            }
            
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
        
        addSubview(speakerButton)
        addSubview(heartButton)
        addSubview(heartButtonTitle)
        addSubview(cantoWordLabel)
        addSubview(middleStackView)
        addSubview(sentenceLabel)
        
        NSLayoutConstraint.activate([
            speakerButton.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            speakerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            speakerButton.widthAnchor.constraint(equalToConstant: 40),
            speakerButton.heightAnchor.constraint(equalToConstant: 40),
            
            heartButton.topAnchor.constraint(equalTo: speakerButton.bottomAnchor, constant: 8),
            heartButton.centerXAnchor.constraint(equalTo: speakerButton.centerXAnchor),
            heartButton.widthAnchor.constraint(equalTo: speakerButton.widthAnchor, multiplier: 1),
            heartButton.heightAnchor.constraint(equalTo: speakerButton.heightAnchor, multiplier: 1),
            
            heartButtonTitle.topAnchor.constraint(equalTo: heartButton.bottomAnchor),
            heartButtonTitle.centerXAnchor.constraint(equalTo: heartButton.centerXAnchor),
            heartButtonTitle.widthAnchor.constraint(equalTo: heartButton.widthAnchor, multiplier: 1.2),
            heartButtonTitle.heightAnchor.constraint(equalToConstant: 20),
            
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

        heartButtonTitle.alpha = 0

    }

}
