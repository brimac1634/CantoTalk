//
//  Favorites.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 4/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import RealmSwift

class Favorites: Object {
    @objc dynamic var entryID : Int = 0
    @objc dynamic var cantoWord : String = ""
    @objc dynamic var jyutping : String = ""
    @objc dynamic var englishWord : String = ""
    @objc dynamic var mandarinWord : String = ""
    @objc dynamic var dateFavorited : String = ""
}
