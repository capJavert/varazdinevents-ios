import Foundation

import RealmSwift


/// Event
public class Event: Object
{
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    @objc dynamic var date = 0
    @objc dynamic var date_to = 0
    @objc dynamic var host = ""
    @objc dynamic var official_link = "link"
    @objc dynamic var image = ""
    @objc dynamic var facebook = ""
    @objc dynamic var offers = "offers"
    @objc dynamic var category = "Ostalo"
    @objc dynamic var author = 0
    @objc dynamic var favorite = false
    
    
    /// Primary key
    ///
    /// - Returns: String
    override public static func primaryKey() -> String? {
        return "id"
    }
}
