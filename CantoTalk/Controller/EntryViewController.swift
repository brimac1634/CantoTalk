//
//  EntryViewController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 1/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class EntryViewController: NSObject {
    
    let blackView = UIView()
    let entryView = UIView()
    
    
    
    func showEntryView() {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            let entryViewHeight = (window.frame.height / 3) * 2
            entryView.backgroundColor = UIColor.cantoWhite(a: 0.9)
            entryView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: entryViewHeight)
            
            window.addSubview(blackView)
            window.addSubview(entryView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.entryView.frame = CGRect(x: 0, y: window.frame.height - entryViewHeight, width: window.frame.width, height: entryViewHeight)
            }, completion: nil)
            
            
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.entryView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: self.entryView.frame.height)
            }
        }
    }
    
}
