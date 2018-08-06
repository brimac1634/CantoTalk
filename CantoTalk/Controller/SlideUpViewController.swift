//
//  SlideUpViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 3/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class SlideUpViewController: NSObject {
    
    let blackView = UIView()
    var whiteView: UIView?

    
    func showEntryView(slideUpView: UIView) {
        if let window = UIApplication.shared.keyWindow {
            
            
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss))
            swipeDownGesture.direction = .down
            slideUpView.addGestureRecognizer(swipeDownGesture)
            
            window.addSubview(blackView)
            window.addSubview(slideUpView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let height = (window.frame.height / 3) * 2
            let y = window.frame.height - height
            slideUpView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            slideUpView.backgroundColor = UIColor.cantoWhite(a: 1)
            
            whiteView = slideUpView
            

            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                slideUpView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            }, completion: nil)

        }
        
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                if let view = self.whiteView {
                    view.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: view.frame.height)
                }
            }
        }
        
    }
    
}
