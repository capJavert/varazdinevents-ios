import Foundation
import SwiftyJSON

public class JsonAdapter
{
    public static func getEvents(json: AnyObject) -> Array<Event>
    {
        var events = [Event]()
        let jsonEvents = JSON(json)
        let items = jsonEvents["items"]
        let itemsString = String(describing: items)
        if let dataFromString = itemsString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let json2 = JSON(data: dataFromString)
            for (_, subJson) in json2 {
                let event:Event = Event()
                event.id = subJson["id"].int!
                event.title = subJson["title"].string!
                event.text = subJson["text"].string!
                event.date = subJson["date"].int!
                event.date_to = subJson["date_to"].int!
                event.host = subJson["host"].string!
                event.official_link = subJson["official_link"].string!
                event.image = subJson["image"].string!
                event.facebook = subJson["facebook"].string!
                //event.offers = subJson["offers"].string!
                events.append(event)
            } }
        return events
    }
    
    public static func getUser(json: AnyObject) -> User
    {
        let user = User()
        let jsonUser = JSON(json)
        let userString = String(describing: jsonUser)
        if let dataFromString = userString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            
            user.id = json["id"].int!
            user.username = json["username"].string!
            user.sessionId = json["token"].string!
            
        }
        return user
    }
}
