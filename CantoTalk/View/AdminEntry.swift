//
//  AdminEntry.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 14/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit

class AdminEntry: BaseView {
    
    let xValue = 8
    var yValue = 0
    let inputHeight = 40
    var tagNo = 0
    var textObjects: [UITextField]?
    
    let placeholders: [String] = ["cantoWord", "jyutping", "wordType", "classifier", "englishWord", "mandarinWord", "cantoSentence", "jyutpingSentence", "englishSentence"]
    
    var viewHeight: CGFloat?
    
    override func setupViews() {
        viewHeight = CGFloat(placeholders.count) * CGFloat(inputHeight + 20)
        for n in 0...self.placeholders.count {
            let inputField = UITextField(frame: CGRect(x: xValue, y: yValue, width: Int(frame.width - 32), height: inputHeight))
            inputField.placeholder = placeholders[n]
            inputField.borderStyle = UITextBorderStyle.roundedRect
            inputField.autocorrectionType = UITextAutocorrectionType.no
            inputField.keyboardType = UIKeyboardType.default
            inputField.returnKeyType = UIReturnKeyType.done
            inputField.clearButtonMode = UITextFieldViewMode.whileEditing;
            inputField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            inputField.delegate = self as? UITextFieldDelegate
            addSubview(inputField)
            textObjects?.append(inputField)
            
            yValue = yValue + inputHeight + 20
            
        }
    }
}
