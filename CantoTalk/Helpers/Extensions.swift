//
//  Extensions.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
    
    
    
}

extension UIColor {
    static func cantoDarkBlue(a: CGFloat) -> UIColor {
        return UIColor(red: 6/255, green: 39/255, blue: 67/255, alpha: a)
    }
    
    static func cantoPink(a: CGFloat) -> UIColor {
        return UIColor(red: 255/255, green: 122/255, blue: 138/255, alpha: a)
    }
    
    static func cantoWhite(a: CGFloat) -> UIColor {
        return UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: a)
    }
    
    static func cantoLightBlue(a: CGFloat) -> UIColor {
        return UIColor(red: 17/255, green: 58/255, blue: 93/255, alpha: a)
    }
}
























