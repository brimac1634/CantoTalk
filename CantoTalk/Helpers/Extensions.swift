//
//  Extensions.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 31/7/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

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

extension Date {
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
}

extension UISearchBar {
    static func resignIfFirstResponder(searchBar: UISearchBar) {
        if  searchBar.isFirstResponder == true {
            searchBar.resignFirstResponder()
        }
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


















