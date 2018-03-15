import Foundation

import RealmSwift


/// EventCategory
public class EventCategory: Object
{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var text: String = ""
}
