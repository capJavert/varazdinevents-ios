import Foundation

import RealmSwift

class User: Object
{
    dynamic var id: Int = 0
    dynamic var username: String = ""
    dynamic var sessionId: String = ""
}
