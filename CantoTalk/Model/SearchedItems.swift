//
//  SearchedItems.swift
//  CantoTalk
//
//  Created by Brian MacPherson on 27/8/2018.
//  Copyright © 2018 Brian MacPherson. All rights reserved.
//

import Foundation
import RealmSwift

class SearchedItems: Object {
    @objc dynamic var searchedItem: String = ""
    @objc dynamic var dateSearched: String = ""
}
