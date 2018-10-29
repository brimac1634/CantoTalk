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
        case addCards
        case delete
        case editCards
    }
    var numberOfStacks: Int = 0
    var alertViewHeight: NSLayoutConstraint!
    var alertViewHeightFloat: CGFloat!
    var alertStackView: UIStackView!
    var buttonStackView: UIStackView!
    
    
    var alert: AlertType? {
        didSet {
            guard let alertView = alert else {return}
            switch alertView {
            case .create:
                message.text = "Name your flash card deck"
            case .rename:
                message.text = "Rename card deck"
                createButton.setTitle("Save", for: .normal)
            case .addCards:
                message.text = "Would you like to add cards now?"
                createButton.setTitle("Add", for: .normal)
                removeTextField()
            case .delete:
                message.text = "Are you sure?"
                createButton.setTitle("Delete", for: .normal)
                removeTextField()
            case .editCards:
                message.text = "Add or remove cards here"
                createButton.setTitle("Okay", for: .normal)
                removeTextField()
                removeCancelButton()
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
        label.backgroundColor = UIColor.cantoWhite(a: 1)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.cantoDarkBlue(a: 1)
        return label
    }()
    
    let textField: UITextField = {
        let tF = UITextField()
        tF.placeholder = "\"Home\", \"Fruits\", etc."
        tF.borderStyle = .roundedRect
        tF.autocorrectionType = .no
        tF.keyboardType = .default
        tF.returnKeyType = .done
        tF.clearButtonMode = .whileEditing
        tF.translatesAutoresizingMaskIntoConstraints = false
        return tF
    }()
    
    let textFieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = UIColor.cantoWhite(a: 1)
        button.setTitleColor(UIColor.cantoDarkBlue(a: 1), for: .normal)
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor.cantoDarkBlue(a: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.cantoWhite(a: 1)
        return button
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        
        buttonStackView = UIStackView(arrangedSubviews: [cancelButton, createButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 1
        
        textFieldContainer.addSubview(textField)
        
        alertStackView = UIStackView(arrangedSubviews: [message, textFieldContainer, buttonStackView])
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
            
            textField.centerXAnchor.constraint(equalTo: textFieldContainer.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: textFieldContainer.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: textFieldContainer.widthAnchor, multiplier: 0.9),
            textField.heightAnchor.constraint(equalTo: textFieldContainer.heightAnchor, multiplier: 0.7),
            
            alertStackView.topAnchor.constraint(equalTo: alertView.topAnchor),
            alertStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            alertStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            alertStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
            ])
        
        
    }
    
    private func removeTextField() {
        alertStackView.removeArrangedSubview(textFieldContainer)
        textFieldContainer.alpha = 0
        numberOfStacks = alertStackView.arrangedSubviews.count
        alertViewHeight.constant = CGFloat(60 * numberOfStacks)
        layoutIfNeeded()
    }
    
    private func removeCancelButton() {
        buttonStackView.removeArrangedSubview(cancelButton)
        cancelButton.alpha = 0
        layoutIfNeeded()
    }
}
