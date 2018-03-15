import Foundation

import RealmSwift


/// User
public class User: Object
{
    @objc dynamic var id: Int = 0
    @objc dynamic var username: String = ""
    @objc dynamic var sessionId: String = ""
    @objc dynamic var token: String = ""
    
    /// Primary key
    ///
    /// - Returns: String
    override public static func primaryKey() -> String? {
        return "id"
    }
}
