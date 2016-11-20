import Foundation

import RealmSwift

public class Event: Object
{
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var text: String = ""
    dynamic var date: Int = 0
    dynamic var date_to: Int = 0
    dynamic var host: String = ""
    dynamic var official_link: String = ""
    dynamic var image: String = ""
    dynamic var facebook: String = ""
    dynamic var offers: String = ""
}
