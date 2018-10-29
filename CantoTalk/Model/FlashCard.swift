//
//  FlashCards.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 27/9/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import RealmSwift

class FlashCard: Object {
    @objc dynamic var entryID: Int = 0
    @objc dynamic var dateAdded: Date?
    @objc dynamic var cardProgress: CGFloat = 0
    
    var parentDeck = LinkingObjects(fromType: FlashCardDeck.self, property: "cards")
}
