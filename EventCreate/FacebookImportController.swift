import UIKit
import FacebookCore
import FacebookLogin

class FacebookImportController: UIViewController {
    var user =  User()
    let loginManager = LoginManager()
    
    struct FacebookRequest: GraphRequestProtocol {
        struct Response: GraphResponseProtocol {
            init(rawResponse: Any?) {
                // Decode JSON from rawResponse into other properties here.
            }
        }
        
        var graphPath = "/me"
        var parameters: [String : Any]? = ["fields": "id, name"]
        var accessToken = AccessToken.current
        var httpMethod: GraphRequestHTTPMethod = .GET
        var apiVersion: GraphAPIVersion = .defaultVersion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AccessToken.current != nil {
            print(AccessToken.current ?? "NO TOKEN")
        } else {
            let loginButton = LoginButton(readPermissions: [ .publicProfile ])
            loginButton.center = self.view.center
            loginButton.sizeToFit()
        
            self.view.addSubview(loginButton)
        }
        
        /*let connection = GraphRequestConnection()
        connection.add(FacebookRequest()) { response, result in
            switch result {
            case .success(let response):
                print(response)
            case .failed(let error):
                print("Custom Graph Request Failed: \(error)")
            }
        }
        connection.start()*/
    }
    
    func displayAlertMessage(userMessage: String){
        
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
}


