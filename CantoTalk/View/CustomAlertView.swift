//
//  CustomAlertView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 28/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class CustomAlertView: BaseView {
    
    
    enum AlertType {
        case create
        case rename
        case delete
    }
    var numberOfStacks: Int = 0
    var alertViewHeight: NSLayoutConstraint!
    var alertViewHeightFloat: CGFloat!
    var alertStackView: UIStackView!
    
    
    var alert: AlertType? {
        didSet {
            print("alert called now")
            guard let alertView = alert else {return}
            switch alertView {
            case .create:
                print("Standard alert")
            case .rename:
                message.text = "Rename card deck."
                createButton.setTitle("Save", for: .normal)
            case .delete:
                message.text = "Are you sure?"
                createButton.setTitle("Delete", for: .normal)
                alertStackView.removeArrangedSubview(textField)
                textField.alpha = 0
                numberOfStacks = alertStackView.arrangedSubviews.count
                alertViewHeight.constant = CGFloat(60 * numberOfStacks)
                layoutIfNeeded()
            }
        }
    }
    
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let message: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name your flash card deck!"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        return label
    }()
    
    let textField: UITextField = {
        let tF = UITextField()
        tF.placeholder = "Ex.: \"Home\", \"Fruits\", etc."
        tF.borderStyle = .roundedRect
        tF.autocorrectionType = .no
        tF.keyboardType = .default
        tF.returnKeyType = .done
        tF.clearButtonMode = .whileEditing
        return tF
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = UIColor.cantoWhite(a: 1)
        button.setTitleColor(UIColor.cantoDarkBlue(a: 1), for: .normal)
        
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor.cantoDarkBlue(a: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor.cantoWhite(a: 1)
        return button
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, createButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 1
        
        alertStackView = UIStackView(arrangedSubviews: [message, textField, buttonStackView])
        alertStackView.axis = .vertical
        alertStackView.distribution = .fillEqually
        alertStackView.spacing = 1
        alertStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(alertView)
        alertView.addSubview(alertStackView)
        
        numberOfStacks = alertStackView.arrangedSubviews.count
        alertViewHeightFloat = CGFloat(60 * numberOfStacks)
        alertViewHeight = alertView.heightAnchor.constraint(equalToConstant: alertViewHeightFloat)
        
        NSLayoutConstraint.activate([

            alertView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: centerYAnchor),
            alertView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            alertViewHeight,
            
            alertStackView.topAnchor.constraint(equalTo: alertView.topAnchor),
            alertStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            alertStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            alertStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
            ])
        
        
    }
}
