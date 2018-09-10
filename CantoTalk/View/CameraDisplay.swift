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
            let text = NSMutableAttributedString(string: entry.cantoWord, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)])
            text.append(NSAttributedString(string: "\n\(entry.englishWord) \(entry.mandarinWord)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 25), NSAttributedStringKey.foregroundColor: UIColor.cantoDarkBlue(a: 1)]))
            
            classificationText.attributedText = text
            
        }
    }
    
    let cameraDisplay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    let classificationText: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isScrollEnabled = false
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor(white: 1, alpha: 0)
        
        addSubview(cameraDisplay)
        addSubview(textView)
        textView.addSubview(classificationText)
        
        NSLayoutConstraint.activate([
            cameraDisplay.topAnchor.constraint(equalTo: topAnchor),
            cameraDisplay.leadingAnchor.constraint(equalTo: leadingAnchor),
            cameraDisplay.trailingAnchor.constraint(equalTo: trailingAnchor),
            cameraDisplay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textView.widthAnchor.constraint(equalToConstant: 200),
            textView.heightAnchor.constraint(equalToConstant: 100),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            
            classificationText.topAnchor.constraint(equalTo: textView.topAnchor),
            classificationText.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            classificationText.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            classificationText.bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            ])
        
    }
    
    
    
}
