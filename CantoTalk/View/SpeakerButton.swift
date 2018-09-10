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
    var spokenWord: String?
    var normalColor = UIColor.cantoWhite(a: 1)
    var selectedColor = UIColor.cantoPink(a: 1)
    
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
    
    
    @objc func handleSpeaker() {
        if speaker.isSpeaking {
            speaker.stopSpeaking(at: .immediate)
            speakerButton.tintColor = normalColor
        } else {
            speakerButton.tintColor = selectedColor
            let audioSession = AVAudioSession.sharedInstance()
            try? audioSession.setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
            
            let voice = AVSpeechSynthesisVoice(language: "zh-HK")
            guard let word = spokenWord else {return}
            let context = AVSpeechUtterance(string: word)
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


