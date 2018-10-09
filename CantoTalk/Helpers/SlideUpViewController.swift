//
//  SlideUpViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 3/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class SlideUpViewController: NSObject {
    
    let blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    let slideUpBottomConstant: CGFloat = 20
    var whiteView: UIView?
    var whiteViewHeight: CGFloat!
    var slideUpViewTopAnchor: NSLayoutConstraint!
    var slideUpViewBottomAnchor: NSLayoutConstraint!

    
    func showEntryView(slideUpView: UIView, viewHeight: CGFloat) {
        if let window = UIApplication.shared.keyWindow {
            
            whiteViewHeight = viewHeight
            slideUpView.translatesAutoresizingMaskIntoConstraints = false
            slideUpView.backgroundColor = UIColor.cantoWhite(a: 1)
            
            window.addSubview(blackView)
            window.addSubview(slideUpView)
            
            slideUpViewTopAnchor = slideUpView.topAnchor.constraint(equalTo: window.bottomAnchor)
            slideUpViewBottomAnchor = slideUpView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: slideUpBottomConstant)
            
            NSLayoutConstraint.activate([
                blackView.topAnchor.constraint(equalTo: window.topAnchor),
                blackView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                blackView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                blackView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                
                slideUpViewTopAnchor,
                slideUpView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                slideUpView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                slideUpView.heightAnchor.constraint(equalToConstant: viewHeight + slideUpBottomConstant)
                ])
            
            window.layoutIfNeeded()

            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            slideUpView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
            
            
            whiteView = slideUpView
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.slideUpViewTopAnchor.isActive = false
                self.slideUpViewBottomAnchor.isActive = true
                window.layoutIfNeeded()
            }, completion: nil)

        }
        
    }
    
    
    //MARK: - Gesture Methods
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                if let window = UIApplication.shared.keyWindow {
                    self.blackView.alpha = 0
                    self.slideUpViewTopAnchor.isActive = true
                    self.slideUpViewBottomAnchor.isActive = false
                    window.layoutIfNeeded()
                }
        }, completion: nil)
        
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard let window = UIApplication.shared.keyWindow else {return}
        let changeInY = gesture.translation(in: whiteView).y
        let velocityY = gesture.velocity(in: whiteView).y
        print(velocityY)
        if changeInY > 0 {
            slideUpViewBottomAnchor.constant = changeInY
            blackView.alpha = 1 - ((changeInY * 100) / whiteViewHeight) * 0.01
            
            if gesture.state == .ended {
                if changeInY > whiteViewHeight * 0.7 || velocityY > 800 {
                    handleDismiss()
                } else {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                        self.slideUpViewBottomAnchor.constant = self.slideUpBottomConstant
                        window.layoutIfNeeded()
                    }, completion: nil)
                }
            }
            
            
        }
        
        
        
           
        
        
    }
    
}
