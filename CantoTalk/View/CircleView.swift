//
//  CircleView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 17/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let radius: Double = Double(rect.width / 2) - 20
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        path.move(to: CGPoint(x: Double(center.x) + radius, y: Double(center.y)))
        
        for i in stride(from: 0, to: 361.0, by: 5) {
            let radians = i * Double.pi / 180
            
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)
            
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        let circumference: CGFloat = (CGFloat(Double.pi * (radius * 2)))
        let dividedBy: CGFloat = 6
        let dashLine = circumference / dividedBy
        UIColor.cantoWhite(a: 1).setStroke()
        path.setLineDash([dashLine, dashLine / dividedBy - 1], count: 2, phase: 0.0)
        path.lineWidth = 3
        path.stroke()
    }
    
//    func animate() {
//        UIView.animate(withDuration: 10, delay: 0, options: [.repeat, .curveLinear], animations: {
//            UIView.animate(withDuration: 5.0, delay: 0, options: .curveLinear, animations: {
//                self.transform = CGAffineTransform(rotationAngle: .pi)
//            }, completion: nil)
//
//            UIView.animate(withDuration: 5.0, delay: 5.0, options: .curveLinear, animations: {
//                self.transform = CGAffineTransform(rotationAngle: .pi * 2)
//            }, completion: nil)
//        }, completion: nil)
//    }
    
    func animate() {
        rotateView(targetView: self, duration: 10)
    }
    

    func pauseAnimation() {
        
    }
    
    func rotateView(targetView: UIView, duration: Double = 10) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear, .beginFromCurrentState], animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat.pi)
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
}
