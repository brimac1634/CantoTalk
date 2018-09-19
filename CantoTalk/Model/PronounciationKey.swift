//
//  PronounciationKeys.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 19/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation

class PronounciationKey {
    let keyWord: String
    let exampleJyutping: String
    let exampleCanto: String
    let englishWord: String
    
    init(key: String, jyutping: String, canto: String, english: String) {
        keyWord = key
        exampleJyutping = jyutping
        exampleCanto = canto
        englishWord = english
    }
}

class PronounciationKeyBank {
    var keys = [PronounciationKey]()
    
    init() {
        let firstKey = PronounciationKey(key: "p", jyutping: "paa1", canto: "趴", english: "prostrate")
        keys.append(firstKey)
        
        keys.append(PronounciationKey(key: "t", jyutping: "taa1", canto: "他", english: "he"))
        keys.append(PronounciationKey(key: "k", jyutping: "kaa1", canto: "卡", english: "card"))
        keys.append(PronounciationKey(key: "c", jyutping: "caa1", canto: "叉", english: "fork"))
        keys.append(PronounciationKey(key: "kw", jyutping: "kwaa1", canto: "誇", english: "boast"))
    }
}
