//
//  DictionaryModel.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 3/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import RealmSwift

class Entries: Object {
    @objc dynamic var entryID : Int = 0
    @objc dynamic var cantoWord : String = ""
    @objc dynamic var jyutping : String = ""
    @objc dynamic var wordType : String = ""
    @objc dynamic var classifier : String? = nil
    @objc dynamic var englishWord : String = ""
    @objc dynamic var mandarinWord : String = ""
    @objc dynamic var cantoSentence : String? = nil
    @objc dynamic var jyutpingSentence : String? = nil
    @objc dynamic var englishSentence : String? = nil
    
    @objc dynamic var dateFavorited : Date? = nil
}

