//
//  FlashCardDeck.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 27/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import RealmSwift

class FlashCardDeck: Object {
    @objc dynamic var deckTitle: String = ""
    @objc dynamic var dateAdded: Date?
    @objc dynamic var progress: Int = 0
    
    let cards = List<FlashCard>()
}
