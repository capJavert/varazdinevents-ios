import Foundation

import RealmSwift

public class User: Object
{
    dynamic var id: Int = 0
    dynamic var username: String = ""
    dynamic var sessionId: String = ""
    dynamic var token: String = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
