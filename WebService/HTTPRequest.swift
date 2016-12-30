import Alamofire

public protocol WebServiceResultDelegate{
    func getResult(json:AnyObject, type: String)
}

public class HTTPRequest
{
    public var baseUrl = "http://varazdinevents.cf/api"
    public var wsResultDelegate:WebServiceResultDelegate?
    public init(){}
    
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
}
