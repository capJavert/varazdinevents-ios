import Foundation

import RealmSwift


/// Host
public class Host: Object
{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var phone = ""
    @objc dynamic var work_hours = ""
    @objc dynamic var facebook = ""
    @objc dynamic var website = ""
    @objc dynamic var about = ""
    @objc dynamic var image = ""
    
    /// Primary key
    ///
    /// - Returns: String
    override public static func primaryKey() -> String? {
        return "id"
    }
}
