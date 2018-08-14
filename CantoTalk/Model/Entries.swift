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
    var jyutping : String = ""
    var wordType : String = ""
    var classifier : String? = nil
    var englishWord : String = ""
    var mandarinWord : String = ""
    var cantoSentence : String? = nil
    var jyutpingSentence : String? = nil
    var englishSentence : String? = nil
    
    var dateFavorited : Date? = nil
}

