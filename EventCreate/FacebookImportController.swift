import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookImportController: UIViewController, FBSDKLoginButtonDelegate {
    var user =  User()
    let loginManager = LoginManager()
    @IBOutlet weak var eventIdField: UITextField!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
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
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            eventIdField.isEnabled = true
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        eventIdField.isEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AccessToken.current == nil {
            eventIdField.isEnabled = false
        }
        
        self.loginButton.delegate = self
        self.loginButton.sizeToFit()
        
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


