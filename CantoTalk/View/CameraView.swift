//
//  CameraView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 6/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import UIKit

class CameraView: BaseView {
    
    let cameraDisplay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let classificationText: UITextView = {
        let label = UITextView()
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
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
            ])
        
        classificationText.frame = textView.frame
    }
    
    
    
}
