//
//  SpeakerButton.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 10/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import AVFoundation

class SpeakerButton: BaseView, AVSpeechSynthesizerDelegate {
    
    let speaker = AVSpeechSynthesizer()
    var spokenWord = ""
    var normalColor = UIColor.cantoWhite(a: 1)
    
    var cantoWord: String? {
        didSet {
            guard let word = cantoWord else {return}
            spokenWord = ""
            parseCantoWord(cantoWord: word)
        }
    }
    
    
    let speakerButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "speaker")?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.cantoWhite(a: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSpeaker), for: .touchUpInside)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        speaker.delegate = self
        
        
        addSubview(speakerButton)
        
        NSLayoutConstraint.activate([
            speakerButton.topAnchor.constraint(equalTo: topAnchor),
            speakerButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            speakerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            speakerButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
       
    }
    
    func setColor(color: UIColor) {
        speakerButton.tintColor = color
    }
    
    func parseCantoWord(cantoWord: String) {
        let wordArray = cantoWord.components(separatedBy: ", ")
        for word in wordArray {
            if word.containsChineseCharacters {
                spokenWord.append("\(word), ")
            }
        }
    }
    
    
    @objc func handleSpeaker() {
        if speaker.isSpeaking {
            speaker.stopSpeaking(at: .immediate)
            speakerButton.tintColor = normalColor
        } else {
            speakerButton.tintColor = UIColor.cantoPink(a: 1)
            let audioSession = AVAudioSession.sharedInstance()
//            try? audioSession.setCategory(convertFromAVAudioSessionCategory(AVAudioSession.Category.playback), with: .duckOthers)
            try? audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)), mode: .default, options: .duckOthers)
            
            let voice = AVSpeechSynthesisVoice(language: "zh-HK")
            let context = AVSpeechUtterance(string: spokenWord)
            context.voice = voice
            speaker.speak(context)
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speakerButton.tintColor = normalColor
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setActive(false)
    }
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
