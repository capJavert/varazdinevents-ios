//
//  ImageViewController.swift
//  VzLife
//
//  Created by FOI on 27/11/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

//Those twovarasses we included so we could use it for layout and as for DataSource for collecetion we are using


class ImageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    struct eventObject{
        var about: String
        var imageUrl: String
    }
    
    var eventsArray: [eventObject] = []
    var events = [Event] ()
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    var user = User()
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        //set default Realm DB configuration
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in })
        
        if user.id != 0 {
            
            self.navigationItem.setHidesBackButton(true, animated:true)
            loginButton.isHidden = true
        }

        
        if(NetworkConnection.Connection.isConnectedToNetwork()){
            webServiceDataLoader.onDataLoadedDelegate = self
            webServiceDataLoader.LoadData()
        }else{
            dbDataLoader.onDataLoadedDelegate = self
            dbDataLoader.LoadData()
        }
        

        //telling CollectionView that stuff he is looking for can be found within this viewController itself
        collectionView.delegate = self
        collectionView.dataSource = self 
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Implementing methods for classes we included
    //First one is for number of items in collectionView ( how many items will we have )
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    
    //Second method we needed is for every cell specifing the properties of it
    // This method is generating cell object and returns it with all properties we need it
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! ImageCollectionViewCell
        cell.aboutView.text = events[indexPath.item].title
        cell.imageView.kf.setImage(with: URL(string: events[indexPath.item].image))
        //setting tag for unique identifing button ( because we can't know which of many buttons in collection is clicked
        cell.moreInfoButton.tag = indexPath.item
        cell.moreInfoButton.event = events[indexPath.item]
        cell.moreInfoButton.addTarget(self, action: #selector(goToEventDetail(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func goToEventDetail( sender: UIButton){
        //passing Sender
        self.performSegue(withIdentifier: "EventDetail", sender: sender)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //We know that sender is a button
        if segue.identifier == "EventDetail"{
            //casting sender to UIButton
            let sender = sender as! EventDetailButton
            let eventDetail = segue.destination as! EventDetailController
            
            eventDetail.event = sender.event
            
        }
    }
    
    @IBAction func toLooginAction(_ sender: Any) {
        
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "loginView") as! LogInViewController
        self.navigationController?.pushViewController(loginView, animated: true)
    }
    
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImageViewController: OnDataLoadedDelegate {
    public func onDataLoaded(events: [Event]) {
        self.events=events
        
        collectionView.reloadData()
        
    }
}
