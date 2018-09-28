//
//  CustomAlertView.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 28/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class CustomAlertView: BaseView {
    
    
    var alertViewHeight: CGFloat = 200
    
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cantoWhite(a: 1)
        view.layer.cornerRadius = 22
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
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor.cantoWhite(a: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = UIColor.cantoDarkBlue(a: 1)
        return button
    }()
    

    
    override func setupViews() {
        super.setupViews()
        
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, createButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        let alertStackView = UIStackView(arrangedSubviews: [message, textField, buttonStackView])
        alertStackView.axis = .vertical
        alertStackView.distribution = .fillEqually
        alertStackView.spacing = 8
        alertStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(alertView)
        alertView.addSubview(alertStackView)

        
        NSLayoutConstraint.activate([

            alertView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: centerYAnchor),
            alertView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            alertView.heightAnchor.constraint(equalToConstant: alertViewHeight),
            
            alertStackView.topAnchor.constraint(equalTo: alertView.topAnchor),
            alertStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            alertStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            alertStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
            ])
        
        
    }
}
