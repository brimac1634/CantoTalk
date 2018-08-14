//
//  AdminEntry.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 14/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class AdminEntry: BaseView, UITextFieldDelegate {
    
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.cantoPink(a: 1)
        button.frame.size = CGSize(width: 200, height: 40)
        button.titleLabel?.text = "Enter"
        button.titleLabel?.textColor = UIColor.cantoDarkBlue(a: 1)
        button.addTarget(self, action: #selector(handleEnter), for: .touchUpInside)
        return button
    }()
    
    let xValue = 16
    var yValue = 16
    let inputHeight = 40
    var tagNo = 0
    var textObjects: [UITextField]?
    
    let placeholders: [String] = ["cantoWord", "jyutping", "wordType", "classifier", "englishWord", "mandarinWord", "cantoSentence", "jyutpingSentence", "englishSentence"]
    
    override func setupViews() {
        for n in 0...self.placeholders.count - 1 {
            let inputField = UITextField(frame: CGRect(x: xValue, y: yValue, width: 200, height: inputHeight))
            inputField.placeholder = placeholders[n]
            inputField.borderStyle = UITextBorderStyle.roundedRect
            inputField.autocorrectionType = UITextAutocorrectionType.no
            inputField.keyboardType = UIKeyboardType.default
            inputField.returnKeyType = UIReturnKeyType.done
            inputField.clearButtonMode = UITextFieldViewMode.whileEditing;
            inputField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            inputField.delegate = self as UITextFieldDelegate
            addSubview(inputField)
            textObjects?.append(inputField)
            
            yValue = yValue + inputHeight + 20
        }
        print(textObjects)
        addSubview(enterButton)
        enterButton.frame = CGRect(x: xValue, y: yValue + 20, width: 200, height: 40)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    @objc func handleEnter() {
        print(123)
        
    }
    
}
