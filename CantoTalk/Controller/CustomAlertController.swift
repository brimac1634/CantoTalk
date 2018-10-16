//
//  CustomAlertController.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 28/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

protocol CustomAlertViewDelegate: class {
    func affirmativeButtonTapped(alertType: Int, textFieldValue: String)
    func cancelButtonTapped()
}

class CustomAlertController: UIViewController {
    
    let customAlertView = CustomAlertView()
    var delegate: CustomAlertViewDelegate?
    var alertType: Int!
    
    class func instantiate(type: CustomAlertView.AlertType) -> CustomAlertController {
        let vc = CustomAlertController()
        vc.customAlertView.alert = type
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        switch type {
        case .create:
            vc.alertType = 0
        case .rename:
            vc.alertType = 1
        case .addCards:
            vc.alertType = 2
        case .delete:
            vc.alertType = 3
        }
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if alertType < 2 {
            customAlertView.textField.becomeFirstResponder()
        }

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
        if let alert = alertType {
            switch alert {
            case 0...1:
                customAlertView.textField.resignFirstResponder()
                delegate?.affirmativeButtonTapped(alertType: alert, textFieldValue: customAlertView.textField.text!)
            case 2...3:
                delegate?.affirmativeButtonTapped(alertType: alert, textFieldValue: "")
            default:
                delegate?.affirmativeButtonTapped(alertType: alert, textFieldValue: "")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }


}
