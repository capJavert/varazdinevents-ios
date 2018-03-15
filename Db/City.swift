//
//  City.swift
//  VzLife
//
//  Created by Ante Baric on 13/05/2017.
//  Copyright © 2017 varazdinevents. All rights reserved.
//

import Foundation
import RealmSwift

/// City
public class City: Object
{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var postal_code = 0
    @objc dynamic var longitude = 0
    @objc dynamic var latitude = 0
    @objc dynamic var active = 0
    
    /// Primary key
    ///
    /// - Returns: String
    override public static func primaryKey() -> String? {
        return "id"
    }
}
