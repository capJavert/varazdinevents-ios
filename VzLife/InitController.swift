//
//  EventController.swift
//  VzLife
//
//  Created by FOI on 27/11/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit
import RealmSwift

//Those twovarasses we included so we could use it for layout and as for DataSource for collecetion we are using


/// Init View Controller
class InitController: UIViewController {
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    var events = [Event] ()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set default Realm DB configuration
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in })
        
        webServiceDataLoader.onUserLoggedDelegate = self
        
        let users = try! Array(Realm().objects(User.self))
        if (users.count > 0) {
            user = users[0]
        }
        
        webServiceDataLoader.CheckUserAuth(sessionId: user.sessionId)
    }
    
    @IBAction func initFirstView(_ sender: Any) {
        performSegue(withIdentifier: "init", sender: sender)
    }

}


// MARK: - OnUserLoggedDelegate
extension InitController: OnUserLoggedDelegate {
    
    /// User logged
    ///
    /// - Parameter user: User
    public func onUserLogged(user: User) {
        self.user = user
        initFirstView(sender: user)
    }
}

/**
 Hide keyboard Extension
 **/

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}
