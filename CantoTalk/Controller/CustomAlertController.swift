//
//  CustomAlertController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 28/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

protocol CustomAlertViewDelegate: class {
    func createButtonTapped(textFieldValue: String)
    func cancelButtonTapped()
}

class CustomAlertController: UIViewController {
    
    let customAlertView = CustomAlertView()
    var delegate: CustomAlertViewDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customAlertView.textField.becomeFirstResponder()
        
        customAlertView.createButton.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        customAlertView.cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    func setupView() {
        customAlertView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customAlertView)
        
        NSLayoutConstraint.activate([
            customAlertView.topAnchor.constraint(equalTo: view.topAnchor),
            customAlertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customAlertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customAlertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        let alertView = customAlertView.alertView
        alertView.alpha = 0
        alertView.frame.origin.y = alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            alertView.alpha = 1.0
            alertView.frame.origin.y = alertView.frame.origin.y - 50
        })
    }
    
    @objc func handleCancel() {
        customAlertView.textField.resignFirstResponder()
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCreate() {
        customAlertView.textField.resignFirstResponder()
        delegate?.createButtonTapped(textFieldValue: customAlertView.textField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
//    func showAlert() {
//        if let window = UIApplication.shared.keyWindow {
//            window.addSubview(customAlertView)
//            customAlertView.frame = window.frame
//
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                let alert = self.customAlertView
//                alert.blackView.alpha = 1
//                alert.alertView.frame = CGRect(x: alert.alertViewX, y: window.frame.height / 2 - self.customAlertView.alertViewHeight / 2, width: alert.alertViewWidth, height: alert.alertViewHeight)
//            }, completion: nil)
//
//        }
//    }
//
//    func dismissAlert() {
//        if let window = UIApplication.shared.keyWindow {
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                let alert = self.customAlertView
//                alert.blackView.alpha = 0
//                alert.alertView.frame = CGRect(x: alert.alertViewX, y: window.frame.height, width: alert.alertViewWidth, height: alert.alertViewHeight)
//            }, completion: nil)
//        }
//    }


}
