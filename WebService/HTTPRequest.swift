import Alamofire

public protocol WebServiceResultDelegate{
    func getResult(json:AnyObject, type: String)
}

public class HTTPRequest
{
    
    public var wsResultDelegate:WebServiceResultDelegate?
    public init(){}
    
    public func requestEvents()
    {
        Alamofire.request("http://varazdinevents.cf/api/events", method: .get, parameters: [:])
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "events")
                }
        }
    }
    
    public func requestUser(username: String, password: String)
    {
        Alamofire.request("http://varazdinevents.cf/api/user/login", method: .post,
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
        Alamofire.request("http://varazdinevents.cf/api/firebase/add/"+token, method: .get)
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    self.wsResultDelegate?.getResult(json: json as AnyObject, type: "user")
                }
        }
    }
}
