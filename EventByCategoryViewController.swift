//

//  VzLife
//
//  Created by FOI on 27/11/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

//Those twovarasses we included so we could use it for layout and as for DataSource for collecetion we are using


class EventByCategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
   
    var events = [Event] ()
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    var user = User()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var aboutView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var moreInfoButton: EventDetailButton!
     override func viewDidLoad() {
        viewDidLoad()
        
        //set default Realm DB configuration
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in })
        
        
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
        
        /* //searchResultUpdateder informs searchBar when search is updated
         searchBarController.searchResultsUpdater = self
         searchBarController.dimsBackgroundDuringPresentation = false
         //to remove search bar from other views if user change the view
         definesPresentationContext = true
         collectionView.*/
        
    }
    
    
     override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
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
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell2", for: indexPath) as! EventByCategoryCollectionViewCell
        cell2.aboutView.text = events[indexPath.item].title
        
        cell2.imageView.kf.setImage(with: URL(string: events[indexPath.item].image))
        //setting tag for unique identifing button ( because we can't know which of many buttons in collection is clicked
        cell2.moreInfoButton.tag = indexPath.item
        cell2.moreInfoButton.event = events[indexPath.item]
       // cell2.moreInfoButton.addTarget(self, action: #selector(goToEventDetail(sender:)), for: .touchUpInside)
        
        return cell2
    }
 
    
  
    
}

extension EventByCategoryViewController: OnDataLoadedDelegate {
    public func onDataLoaded(events: [Event]) {
        self.events=events
        
    }
    
}



