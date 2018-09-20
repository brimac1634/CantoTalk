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
    var keys = [[PronounciationKey]]()
    var keyHeaders = [String]()
    
    init() {
        
        keyHeaders = ["Cantonese Initials", "Aspirated:", "Unaspirated:", "Nasal:"]
        
        keys = [
            [],
            [PronounciationKey(key: "p", jyutping: "paa1", canto: "趴", english: "prostrate"),
             PronounciationKey(key: "t", jyutping: "taa1", canto: "他", english: "he"),
             PronounciationKey(key: "k", jyutping: "kaa1", canto: "卡", english: "card"),
             PronounciationKey(key: "c", jyutping: "caa1", canto: "叉", english: "fork"),
             PronounciationKey(key: "kw", jyutping: "kwaa1", canto: "誇", english: "boast")
            ],
            
            [PronounciationKey(key: "b", jyutping: "baa1", canto: "爸", english: "father"),
             PronounciationKey(key: "d", jyutping: "daa1", canto: "打", english: "dozen"),
             PronounciationKey(key: "g", jyutping: "gaa1", canto: "家", english: "family"),
             PronounciationKey(key: "z", jyutping: "zaa1", canto: "渣", english: "dregs"),
             PronounciationKey(key: "gw", jyutping: "gwaa1", canto: "瓜", english: "melon")
            ],
            
            [PronounciationKey(key: "m", jyutping: "maa1", canto: "媽", english: "mother"),
             PronounciationKey(key: "n", jyutping: "naa1", canto: "哪", english: "scar")
            ]
        ]
        
    }
}
