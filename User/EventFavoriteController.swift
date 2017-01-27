import UIKit
import RealmSwift
import Kingfisher
import Realm


class EventFavoriteController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    
    var events = [Event] ()
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    var user = User()
    var searchBarController: UISearchController!
    var searchText: String = ""
    var emptyList = false
    var cellsNum: Int { return events.count }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var availabilityText: UITextField!
    
    @IBOutlet weak var aboutView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var moreInfoButton: EventDetailButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //telling CollectionView that stuff he is looking for can be found within this viewController itself
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationItem.title = "Favoriti"
        
        //set collection view size
        collectionView.frame.size.width = self.view.frame.width
    }
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        let predicate = NSPredicate(format: "favorite = YES")
        self.events = try! Array(Realm().objects(Event.self).filter(predicate))
        
        collectionView.reloadData()
        
        emptyList = false
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
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
            self.navigationItem.title = "Favoriti"
            let predicate = NSPredicate(format: "favorite = YES")
            self.events = try! Array(Realm().objects(Event.self).filter(predicate))
            self.collectionView!.reloadData()
        }
    }
    
    
    //Implementing methods for classes we included
    //First one is for number of items in collectionView ( how many items will we have )
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (events.count == 0){
            emptyList = true
        }
        else{
            emptyList = false
        }
        if(emptyList){
            availabilityText.isHidden = false
        }
        else{
            availabilityText.isHidden = true
        }
        
        return events.count
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchText = searchBar.text!
        
        //whetever search I'm making will be the title of the search text
        self.navigationItem.title = searchText.uppercased()
        let predicate = NSPredicate(format: "title CONTAINS %@ AND favorite = YES", searchText)
        self.events = try! Array(Realm().objects(Event.self).filter(predicate))
        self.collectionView!.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Second method we needed is for every cell specifing the properties of it
    // This method is generating cell object and returns it with all properties we need it
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell2", for: indexPath) as! EventCategoryCell
        cell2.aboutView.text = events[indexPath.item].title
        
        cell2.imageView.kf.setImage(with: URL(string: events[indexPath.item].image))
        //setting tag for unique identifing button ( because we can't know which of many buttons in collection is clicked
        cell2.moreInfoButton.tag = indexPath.item
        cell2.moreInfoButton.event = events[indexPath.item]
        cell2.moreInfoButton.addTarget(self, action: #selector(goToEventDetail(sender:)), for: .touchUpInside)
        
        return cell2
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
}



