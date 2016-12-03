import Foundation

import RealmSwift

public class Event: Object
{
    dynamic var id = 0
    dynamic var title = ""
    dynamic var text = ""
    dynamic var date = 0
    dynamic var date_to = 0
    dynamic var host = ""
    dynamic var official_link = "link"
    dynamic var image = ""
    dynamic var facebook = ""
    dynamic var offers = "offers"
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
