//
//  CameraView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 6/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import UIKit

class CameraDisplay: BaseView {
    
    var selectedEntry: Entries? {
        didSet {
            guard let entry = selectedEntry else {return}
            
            let topText = NSMutableAttributedString(string: entry.cantoWord, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.cantoWhite(a: 1)])
            if entry.classifier != "" {
                topText.append(NSAttributedString(string: " (cl:\(entry.classifier))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.cantoWhite(a: 1)]))
            }
            topText.append(NSAttributedString(string: "  \(entry.jyutping)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.cantoWhite(a: 1)]))
            
            topTextView.attributedText = topText
            
            let bottomText = NSMutableAttributedString(string: "\nEn: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.cantoLightBlue(a: 0.8)])
            bottomText.append(NSAttributedString(string: entry.englishWord, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            bottomText.append(NSMutableAttributedString(string: "  普: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.cantoLightBlue(a: 0.8)]))
            bottomText.append(NSAttributedString(string: entry.mandarinWord, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            
            bottomTextView.attributedText = bottomText
            
            speakerButton.cantoWord = entry.cantoWord
            
        }
    }
    
    let cameraDisplay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let circleView: CircleView = {
        let shape = CircleView()
        shape.backgroundColor = .clear
        shape.alpha = shape.unselectedAlpha
        shape.translatesAutoresizingMaskIntoConstraints = false
        return shape
    }()
    
    let textView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.dropShadow()
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
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.dropShadow()
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
    
    let speakerButton: SpeakerButton = {
        let button = SpeakerButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor(white: 1, alpha: 0)
        
        let stackView = UIStackView(arrangedSubviews: [topTextView, bottomTextView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        addSubview(cameraDisplay)
        addSubview(circleView)
        addSubview(textView)
        textView.addSubview(topBlueView)
        textView.addSubview(stackView)
        textView.addSubview(speakerButton)
        
        NSLayoutConstraint.activate([
            cameraDisplay.topAnchor.constraint(equalTo: topAnchor),
            cameraDisplay.leadingAnchor.constraint(equalTo: leadingAnchor),
            cameraDisplay.trailingAnchor.constraint(equalTo: trailingAnchor),
            cameraDisplay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            circleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: 1),
            
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            textView.heightAnchor.constraint(equalToConstant: 120),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
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
