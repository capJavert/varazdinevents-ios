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
        let eventController = self.storyboard?.instantiateViewController(withIdentifier: "eventsView") as! EventController
        eventController.user = user
        print(user)
        self.navigationController?.show(eventController, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "init" {
            let sender = sender as! User
            let eventList = segue.destination as! EventController
            
            eventList.user = sender
            
        }
    }
}

extension InitController: OnUserLoggedDelegate {
    public func onUserLogged(user: User) {
        self.user = user
        print(user)
        initFirstView(sender: user)
    }
}
