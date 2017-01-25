//
//  EventController.swift
//  VzLife
//
//  Created by FOI on 27/11/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

//Those twovarasses we included so we could use it for layout and as for DataSource for collecetion we are using


class EventController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    struct eventObject{
        var about: String
        var imageUrl: String
    }
    var dataSource : Results<Event>!
    var eventsArray: [eventObject] = []
    var events = [Event] ()
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    var user = User()
    var searchBarController: UISearchController!
    var searchText: String = ""
    var userUiItems: [UIBarButtonItem] = []
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loginButton: UIBarButtonItem!
    @IBOutlet weak var createEventButton: UIBarButtonItem!
    
    @IBAction func searchBarAction(_ sender: Any) {
        searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.searchBar.delegate = self
        //hide navigatiobar during search
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.text = searchText
        searchBarController.searchBar.barTintColor = UIColor(red: 50/255, green: 60/255, blue: 72/255, alpha: 1.0)
        searchBarController.searchBar.tintColor = UIColor.white
        present(searchBarController, animated: true, completion: nil)
    }
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "") {
            self.navigationItem.title = searchText.uppercased()
            self.events = try! Array(Realm().objects(Event.self))
            self.collectionView!.reloadData()
        }
    }
    
    @IBAction func goToCreationEvent(_ sender: Any) {
        
        let eventCreateView = self.storyboard?.instantiateViewController(withIdentifier: "eventCreate") as! EventCreateController
       
        eventCreateView.user = user
        self.navigationController?.pushViewController(eventCreateView, animated: true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchText = searchBar.text!
        
        //whetever search I'm making will be the title of the search text
        self.navigationItem.title = searchText.uppercased()
        let predicate = NSPredicate(format: "title CONTAINS %@", searchText)
        self.events = try! Array(Realm().objects(Event.self).filter(predicate))
        self.collectionView!.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //save navigation items
        userUiItems.append(loginButton)
        userUiItems.append(createEventButton)
        
        self.tabBarController?.tabBar.isHidden = false
  
        if(NetworkConnection.Connection.isConnectedToNetwork()){
            webServiceDataLoader.onDataLoadedDelegate = self
            webServiceDataLoader.LoadData()
        }else{
            dbDataLoader.onDataLoadedDelegate = self
            dbDataLoader.LoadData()
        }
        
        //refresh option
        self.collectionView.addSubview(self.refreshControl)
        
        //telling CollectionView that stuff he is looking for can be found within this viewController itself
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //set collection view size
        collectionView.frame.size.width = self.view.frame.width
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let users = try! Array(Realm().objects(User.self))
        if (users.count > 0) {
            user = users[0]
        }
        
        if user.id != 0 {
            self.navigationItem.setLeftBarButtonItems([userUiItems[1]], animated: false)
        }
        else {
            self.navigationItem.setLeftBarButtonItems([userUiItems[0]], animated: false)
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        if(NetworkConnection.Connection.isConnectedToNetwork()){
            webServiceDataLoader.onDataLoadedDelegate = self
            webServiceDataLoader.LoadData()
        }
        
        refreshControl.endRefreshing()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
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
        performSegue(withIdentifier: "toLogInAction", sender: loginButton)
    }
}

extension EventController: OnDataLoadedDelegate {
    public func onDataLoaded(events: [Event]) {
        self.events=events
        collectionView.reloadData()
    }
    
    public func onDataLoaded(users: User){
        self.user = users
    
    }
}


