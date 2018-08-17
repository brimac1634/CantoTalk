//
//  AdminEntry.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 14/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import UIKit
import RealmSwift

class AdminEntry: BaseView, UITextFieldDelegate {
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.cantoPink(a: 1)
        button.frame.size = CGSize(width: 200, height: 40)
        button.setTitle("Enter", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleEnter), for: .touchUpInside)
        return button
    }()
    
    let xValue = 16
    var yValue = 16
    let inputHeight = 40
    var tagNo = 0
    var numberOfEntries: Int?
    var homeController: HomeController?
    
    let mainRealm = try! Realm(configuration: Realm.Configuration(fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"), readOnly: false))
    
    var entries: Results<Entries>?
    var textFieldArray = [UITextField]()
    
    let placeholders: [String] = ["cantoWord", "jyutping", "wordType", "classifier", "englishWord", "mandarinWord", "cantoSentence", "jyutpingSentence", "englishSentence"]
    
    override func setupViews() {
        
        entries = mainRealm.objects(Entries.self)
        numberOfEntries = entries?.count
        
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
            textFieldArray.append(inputField)
            yValue = yValue + inputHeight + 20
        }
        addSubview(enterButton)
        enterButton.frame = CGRect(x: xValue, y: yValue + 20, width: 200, height: 40)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    @objc func handleEnter() {
        
        
        try! mainRealm.write {
            let newEntry = Entries()
            if let number = numberOfEntries {
                print(number)
                newEntry.entryID = number + 1
            }
            
            newEntry.cantoWord = textFieldArray[0].text ?? ""
            newEntry.jyutping = textFieldArray[1].text ?? ""
            newEntry.wordType = textFieldArray[2].text ?? ""
            newEntry.classifier = textFieldArray[3].text ?? ""
            newEntry.englishWord = textFieldArray[4].text ?? ""
            newEntry.mandarinWord = textFieldArray[5].text ?? ""
            newEntry.cantoSentence = textFieldArray[6].text ?? ""
            newEntry.jyutpingSentence = textFieldArray[7].text ?? ""
            newEntry.englishSentence = textFieldArray[8].text ?? ""
            
            mainRealm.add(newEntry)
            
            print("Success")
        }
        
        for textField in textFieldArray {
            textField.text = ""
        }
        
    }
    
}
