import UIKit

class CategoryController: UITableViewController, UISearchBarDelegate {

    let categories = ["Kazalište i film", "Slušaona", "Svirka", "Volontiranje", " Tečaj", "Predavanje", "Party","Ostalo","Arhiva događaja"]
    var filteredCategories = [String]()
    var user = User()
    var searchBar = UISearchBar()
    var resultController = UITableViewController()
    var shouldShowResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        // Do any additional setup after loading the view.
    }

    func createSearchBar(){
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Pretraži"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldShowResults{
            return filteredCategories.count
        }
        else{
            return categories.count
        }
    }
    
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    if shouldShowResults {
        cell.textLabel?.text = filteredCategories[indexPath.row]
        return cell
    }
    else {
        cell.textLabel?.text = categories[indexPath.row]
        return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "eventsByCategories", sender: categories[indexPath.row])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCategories = categories.filter({(names: String) -> Bool in
            return (names.lowercased().range(of: searchText.lowercased()) != nil)
            })
            
            if searchText != ""{
                shouldShowResults = true
                self.tableView.reloadData()
            }
            else {
                shouldShowResults = false
                self.tableView.reloadData()
            }
            
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventsByCategories"{
        let eventsByCategories = segue.destination as! EventCategoryController
        let sender = sender as! String
        eventsByCategories.category = sender
        }
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        shouldShowResults = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
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