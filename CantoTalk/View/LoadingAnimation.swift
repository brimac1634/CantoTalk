//
//  LoadingAnimation.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 5/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import UIKit

class LoadingAnimation: BaseView {
    
    let loadingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.animatedImageNamed("CantoTalkIconAnimation", duration: 1)
        image.alpha = 0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func setupViews() {
        super.setupViews()
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(loadingImage)
        
        NSLayoutConstraint.activate([
            loadingImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            loadingImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1)
            ])
    }
    
    func loadAnimation(view: UIView, diameter: CGFloat) {
        
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.widthAnchor.constraint(equalToConstant: diameter),
            self.heightAnchor.constraint(equalToConstant: diameter)
            ])
        
        UIView.animate(withDuration: 0.2) {
            self.loadingImage.alpha = 1
        }
    }
    
    func stopAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.loadingImage.alpha = 0
        }
    }
    
    
}
