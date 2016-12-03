import Alamofire

public protocol WebServiceResultDelegate{
    func getResult(json:AnyObject)
}

public class HTTPRequest
{
    
    public var wsResultDelegate:WebServiceResultDelegate?
    public init(){}
    
    public func httprequest(url: String, method: HTTPMethod, params: [String:String])
    {
        Alamofire.request(url, method: method, parameters: params)
            .responseJSON { response in
                if let json = response.result.value{
                    //NSLog("JSON: \(json)")
                    self.wsResultDelegate?.getResult(json: json as AnyObject)
                }
        }
    }
}
