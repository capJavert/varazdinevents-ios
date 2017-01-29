import Foundation

import RealmSwift


/// Host
public class Host: Object
{
    dynamic var id = 0
    dynamic var name = ""
    dynamic var address = ""
    dynamic var phone = ""
    dynamic var work_hours = ""
    dynamic var facebook = ""
    dynamic var website = ""
    dynamic var about = ""
    dynamic var image = ""
    
    /// Primary key
    ///
    /// - Returns: String
    override public static func primaryKey() -> String? {
        return "id"
    }
}
