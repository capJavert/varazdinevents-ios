import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
import RealmSwift

class FacebookImportController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    var user =  User()
    let loginManager = LoginManager()
    let webService = WebServiceDataLoader()
    @IBOutlet weak var eventIdField: UITextField!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        eventIdField.isEnabled = true
        
        if ((error) != nil) {
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
            eventIdField.isEnabled = false
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        eventIdField.isEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboard setting
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //hide keyboard on click
        self.hideKeyboardWhenTappedAround()
        
        let users = try! Array(Realm().objects(User.self))
        if (users.count > 0) {
            user = users[0]
        }
        
        if AccessToken.current == nil {
            eventIdField.isEnabled = false
        } else {
            //logged in
        }
        
        loginButton.delegate = self
        loginButton.sizeToFit()
        
        eventIdField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if AccessToken.current == nil {
            return false
        } else {
            webService.onEventCreatedDelegate = self
            webService.CreateFacebookEvent(eventId: textField.text!, sessionId: self.user.sessionId, oAuthToken: (AccessToken.current?.authenticationToken)!)
            
            return true
        }
    }
    
    func displayAlertMessage(userMessage: String){
        
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
}

extension FacebookImportController: OnEventCreatedDelegate {
    public func onEventCreated(status: Bool) {
        if(status) {
            let goBackToCollectionView = self.storyboard?.instantiateViewController(withIdentifier:"eventsView") as! EventController
            goBackToCollectionView.user = user
            self.navigationController?.pushViewController(goBackToCollectionView, animated: true)
        } else {
            self.displayAlertMessage(userMessage: "Neispravan ID Facebook događaja!")
        }
    }
}
