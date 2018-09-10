//
//  CameraView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 6/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CameraDisplay: BaseView, AVSpeechSynthesizerDelegate {
    
    let speaker = AVSpeechSynthesizer()
    
    var selectedEntry: Entries? {
        didSet {
            guard let entry = selectedEntry else {return}
            let topText = NSMutableAttributedString(string: entry.cantoWord, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.cantoWhite(a: 1)])
            if entry.classifier != "" {
                topText.append(NSAttributedString(string: " (cl:\(entry.classifier))", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.cantoWhite(a: 1)]))
            }
            topText.append(NSAttributedString(string: "\(entry.jyutping)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.cantoWhite(a: 1)]))
            
            topTextView.attributedText = topText
            
            let bottomText = NSMutableAttributedString(string: "\nEn: ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.cantoLightBlue(a: 0.8)])
            bottomText.append(NSAttributedString(string: entry.englishWord, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            bottomText.append(NSMutableAttributedString(string: " 普: ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.cantoLightBlue(a: 0.8)]))
            bottomText.append(NSAttributedString(string: entry.mandarinWord, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            
            bottomTextView.attributedText = bottomText
            print(bottomText)
            
        }
    }
    
    let cameraDisplay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    let textView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topTextView: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.textAlignment = .center
        label.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topBlueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.mask?.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomTextView: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.textAlignment = .center
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let speakerButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "speaker")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.cantoWhite(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSpeaker), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSpeaker() {
        if speaker.isSpeaking {
            speaker.stopSpeaking(at: .immediate)
            speakerButton.tintColor = UIColor.cantoWhite(a: 1)
        } else {
            speakerButton.tintColor = UIColor.cantoPink(a: 1)
            let audioSession = AVAudioSession.sharedInstance()
            try? audioSession.setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
            
            guard let cantoWord = selectedEntry?.cantoWord else {return}
            let voice = AVSpeechSynthesisVoice(language: "zh-HK")
            let context = AVSpeechUtterance(string: cantoWord)
            context.voice = voice
            speaker.speak(context)
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speakerButton.tintColor = UIColor.cantoWhite(a: 1)
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setActive(false)
    }
    
    override func setupViews() {
        super.setupViews()
        speaker.delegate = self
        
        backgroundColor = UIColor(white: 1, alpha: 0)
        
        let stackView = UIStackView(arrangedSubviews: [topTextView, bottomTextView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        addSubview(cameraDisplay)
        addSubview(textView)
        textView.addSubview(topBlueView)
        textView.addSubview(stackView)
        textView.addSubview(speakerButton)
        
        NSLayoutConstraint.activate([
            cameraDisplay.topAnchor.constraint(equalTo: topAnchor),
            cameraDisplay.leadingAnchor.constraint(equalTo: leadingAnchor),
            cameraDisplay.trailingAnchor.constraint(equalTo: trailingAnchor),
            cameraDisplay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            textView.heightAnchor.constraint(equalToConstant: 120),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            
            topBlueView.topAnchor.constraint(equalTo: textView.topAnchor),
            topBlueView.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            topBlueView.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            topBlueView.heightAnchor.constraint(equalTo: textView.heightAnchor, multiplier: 0.5),
            
            speakerButton.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            speakerButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -16),
            speakerButton.widthAnchor.constraint(equalToConstant: 40),
            speakerButton.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: textView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: speakerButton.leadingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            ])
        
    }
    
    
    
}
