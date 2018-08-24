//
//  WordOfTheDayEntries.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 22/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import RealmSwift

class WordOfTheDay: Object {
    @objc dynamic var entryID : Int = 0
    @objc dynamic var cantoWord : String = ""
    @objc dynamic var jyutping : String = ""
    @objc dynamic var wordType : String = ""
    @objc dynamic var classifier : String = ""
    @objc dynamic var englishWord : String = ""
    @objc dynamic var mandarinWord : String = ""
    @objc dynamic var cantoSentence : String = ""
    @objc dynamic var jyutpingSentence : String = ""
    @objc dynamic var englishSentence : String = ""
    @objc dynamic var dateAdded : String = ""
    
}
