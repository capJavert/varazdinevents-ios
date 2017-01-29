import Alamofire


/// Web service delegate
public protocol WebServiceResultDelegate{
    
    /// Get results
    ///
    /// - Parameters:
    ///   - json: json
    ///   - type: String
    func getResult(json:AnyObject, type: String)
}


/// Reguest data from Web service through HTTP
public class HTTPRequest
{
    
    /// API Url
    public var baseUrl = "http://varazdinevents.cf/api"
    
    /// Web service result delegate
    public var wsResultDelegate:WebServiceResultDelegate?
    
    /// Init
    public init(){}
    
    
    /// Request Events
    public func requestEvents()
    {
        Alamofire.request(baseUrl+"/events", method: .get, parameters: [:])
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "events")
                }
        }
    }
    
    
    /// Login User
    ///
    /// - Parameters:
    ///   - username: username
    ///   - password: password
    public func requestUser(username: String, password: String)
    {
        Alamofire.request(baseUrl+"/user/login", method: .post,
                          parameters: ["username": username, "password": password])
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "user")
                }
        }
    }
    
    
    /// Request Auth token
    ///
    /// - Parameter sessionId: User sessionId
    public func requestAuth(sessionId: String)
    {
        Alamofire.request(baseUrl+"/user/auth?token="+sessionId, method: .get, parameters: [:])
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "auth")
                }
        }
    }
    
    
    /// Register Firebase token for device
    ///
    /// - Parameter token: Firebase token
    public func registerToken(token: String)
    {
        Alamofire.request(baseUrl+"/firebase/add/"+token, method: .get)
            .responseJSON { response in
                if response.result.value != nil{
                    //NSLog("JSON: \(json)")
                    //self.wsResultDelegate?.getResult(json: json as AnyObject, type: "user")
                }
        }
    }
    
    
    /// Favorite event
    ///
    /// - Parameters:
    ///   - token: User sessionId
    ///   - eventId: EventId
    public func favoriteEvent(token: String, eventId: Int)
    {
        Alamofire.request(baseUrl+"/firebase/favorite/"+String(eventId), method: .get, parameters: ["token": token])
            .responseJSON { response in
                if response.result.value != nil{
                    //NSLog("JSON: \(json)")
                    //self.wsResultDelegate?.getResult(json: json as AnyObject, type: "user")
                }
        }
    }
    
    
    /// Unfavorite Event
    ///
    /// - Parameters:
    ///   - token: User sessionId
    ///   - eventId: Event Id
    public func unFavoriteEvent(token: String, eventId: Int)
    {
        Alamofire.request(baseUrl+"/firebase/un-favorite/"+String(eventId), method: .get, parameters: ["token": token])
            .responseJSON { response in
                if response.result.value != nil{
                    //NSLog("JSON: \(json)")
                    //self.wsResultDelegate?.getResult(json: json as AnyObject, type: "user")
                }
        }
    }
    
    
    /// Create Event
    ///
    /// - Parameters:
    ///   - data: Event data
    ///   - sessionId: User sessionId
    public func createEvent(data: [String: Any], sessionId: String)
    {
        var request = URLRequest(url: NSURL(string: baseUrl+"/events?token="+sessionId) as! URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: data)
        
        Alamofire.request(request).responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "event")
                }
        }
    }
    
    
    /// Request Hosts
    public func requestHosts()
    {
        Alamofire.request(baseUrl+"/hosts", method: .get, parameters: [:])
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "hosts")
                }
        }
    }
    
    
    /// Import Facebook event from Graph api
    ///
    /// - Parameters:
    ///   - eventId: Facebook event Id
    ///   - sessionId: User SessionId
    ///   - oAuthToken: oAuth Token
    public func createFacebookEvent(eventId: String, sessionId: String, oAuthToken: String)
    {
        Alamofire.request(baseUrl+"/events/facebook/"+eventId, method: .get, parameters: ["oauth": oAuthToken, "token": sessionId])
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "facebook")
                }
        }
    }
    
    
    /// Get Lat:Lng of address from Google Geocoding API
    ///
    /// - Parameter address: Address
    public func getLatLngFromAddress(address: String)
    {
        var googleWebApiKey = ""
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            googleWebApiKey = (dict["GoogleWebApiKey"] as? String)!
        }
        
        
        Alamofire.request("https://maps.googleapis.com/maps/api/geocode/json", method: .get, parameters: ["address": address, "key": googleWebApiKey])
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "location")
                }
        }
    }
}
