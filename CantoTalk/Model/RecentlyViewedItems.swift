//
//  SearchedItems.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 27/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import RealmSwift

class RecentlyViewedItems: Object {
    @objc dynamic var entryID: Int = 0
    @objc dynamic var dateViewed: String = ""
}
