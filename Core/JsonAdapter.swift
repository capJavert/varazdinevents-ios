import Foundation
import SwiftyJSON


/// Base Json parser
public class JsonAdapter
{
    
    /// Parse JSON Events
    ///
    /// - Parameter json: json
    /// - Returns: Array<Event>
    public static func getEvents(json: AnyObject) -> Array<Event>
    {
        var events = [Event]()
        let jsonEvents = JSON(json)
        let items = jsonEvents["items"]
        
        if (jsonEvents["items"].count > 0) {
            let itemsString = String(describing: items)
            if let dataFromString = itemsString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    let json2 = try JSON(data: dataFromString)
                    
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
                        event.category = subJson["category"].string!
                        event.author = subJson["author"].int!
                        //event.offers = subJson["offers"].string!
                        events.append(event)
                    }
                } catch {
                    print("error decoding")
                }
            }
        }
        return events
    }
    
    
    /// Parse JSON Event
    ///
    /// - Parameter json: json
    /// - Returns: Event
    public static func getEvent(json: AnyObject) -> Event
    {
        let event = Event()
        let jsonEvent = JSON(json)
        let eventString = String(describing: jsonEvent)
        if let dataFromString = eventString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let json = try! JSON(data: dataFromString)
                let event:Event = Event()
                event.id = json["id"].int!
                event.title = json["title"].string!
                event.text = json["text"].string!
                event.date = json["date"].int!
                event.date_to = json["date_to"].int!
                event.host = json["host"].string!
                event.official_link = json["official_link"].string!
                event.image = json["image"].string!
                event.facebook = json["facebook"].string!
                event.category = json["category"].string!
                //event.offers = json["offers"].
        }
        
        return event
    }
    
    
    /// Parse JSON User
    ///
    /// - Parameter json: json
    /// - Returns: User
    public static func getUser(json: AnyObject) -> User
    {
        let user = User()
        let jsonUser = JSON(json)
        let userString = String(describing: jsonUser)
        if let dataFromString = userString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                let json = try JSON(data: dataFromString)
                
                //check if valid user id is returned
                if(json["id"].exists()) {
                    user.id = json["id"].int!
                    user.username = json["username"].string!
                    user.sessionId = json["token"].string!
                }
            } catch {
                print("decode error")
            }
        }
        
        return user
    }
    
    
    /// Parse JSON Hosts
    ///
    /// - Parameter json: json
    /// - Returns: Array<Host>
    public static func getHosts(json: AnyObject) -> Array<Host>
    {
        var hosts = [Host]()
        let jsonEvents = JSON(json)
        let items = jsonEvents["items"]
        let itemsString = String(describing: items)
        if let dataFromString = itemsString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let json2 = try! JSON(data: dataFromString)
            for (_, subJson) in json2 {
                let host:Host = Host()
                host.id = subJson["id"].int!
                host.name = subJson["name"].string!
                host.address = subJson["address"].string!
                host.phone = subJson["phone"].string!
                host.work_hours = subJson["work_hours"].string!
                host.facebook = subJson["facebook"].string!
                host.website = subJson["website"].string!
                host.about = subJson["about"].string!
                host.image = subJson["image"].string!
                hosts.append(host)
            } }
        return hosts
    }
    
    
    /// Parse JSON Cities
    ///
    /// - Parameter json: json
    /// - Returns: Array<City>
    public static func getCities(json: AnyObject) -> Array<City>
    {
        var cities = [City]()
        let jsonEvents = JSON(json)
        let items = jsonEvents["items"]
        let itemsString = String(describing: items)
        if let dataFromString = itemsString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                let json2 = try JSON(data: dataFromString)
                for (_, subJson) in json2 {
                    let city:City = City()
                    city.id = subJson["id"].int!
                    city.name = subJson["name"].string!
                    city.postal_code = subJson["postal_code"].int!
                    city.longitude = subJson["longitude"].int!
                    city.latitude = subJson["latitude"].int!
                    cities.append(city)
                }
            } catch {
                print("decode error")
            }
        }
        
        return cities
    }
    
    
    /// Parse JSON Status
    ///
    /// - Parameter json: json
    /// - Returns: Bool
    public static func getFacebookImportStatus(json: AnyObject) -> Bool
    {
        let jsonStatus = JSON(json)
        let userString = String(describing: jsonStatus)
        if let dataFromString = userString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                let json = try JSON(data: dataFromString)
                
                if(json["success"].exists()){
                    return true
                }
            } catch {
                print("decode error")
            }
        }
        
        return false
    }
    
    
    /// Parse JSON Location
    ///
    /// - Parameter json: json
    /// - Returns: Dictionary<String, Any>
    public static func getLocation(json: AnyObject) -> Dictionary<String, Any>
    {
        var location = Dictionary<String, Any>()
        
        var data = JSON(json)
        var subJson = String(describing: data["results"][0])
        if let dataFromString = subJson.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            do {
                data = try JSON(data: dataFromString)
                
                if(data["formatted_address"].exists()) {
                    location["address"] = data["formatted_address"].string!
                }
                
                subJson = String(describing: data["geometry"])
                if let dataFromString = subJson.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                    data = try JSON(data: dataFromString)
                    
                    subJson = String(describing: data["location"])
                    if let dataFromString = subJson.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                        data = try JSON(data: dataFromString)
                        
                        if(data["lat"].exists() && data["lng"].exists()) {
                            location["lat"] = data["lat"].double!
                            location["lng"] = data["lng"].double!
                        }
                    }
                }
            } catch {
                print("decode error")
            }
        }
        
        return location
    }
}
