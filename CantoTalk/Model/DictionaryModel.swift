//
//  DictionaryModel.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 3/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation

class Entries: NSObject {
    var entryID : Int = 0
    var cantoWord : String = ""
    var englishWord : String = ""
    var mandarinWord : String = ""
    var jyutping : String = ""
    var wordType : String = ""
    var classifier : String?
    var cantoSentence : String?
    var isFavorited : Bool = false
    var dateFavorited : Date?
    
}
