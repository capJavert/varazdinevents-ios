import Alamofire
import SwiftyJSON

public class HTTPRequest
{
    public static var sharedWSInstance = HTTPRequest()
    public func httprequest(url: String, params: [String:String], completion: @escaping (AnyObject) -> Void)
    {
        Alamofire.request(url, method: .post)
            .responseJSON { response in
                if let json = response.result.value{
                    completion(json as AnyObject)
                }
        }
    }
}
