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
    @objc dynamic var dateAdded : String = ""
    
}
