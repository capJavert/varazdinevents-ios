//
//  CategoriesViewController.swift
//  VzLife
//
//  Created by FOI on 26/12/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit
import RealmSwift


class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

   
  
    @IBOutlet weak var tableView: UITableView!
    
    var categories = [EventCategory]()
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

        
        
      tableView.delegate = self
       tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  /* override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  categories.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.item].name
        return cell
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



extension  CategoriesViewController: OnDataLoadedDelegate {
    public func onDataLoaded(categories: [EventCategory]) {
        self.categories=categories
        
        tableView.reloadData()
        
    }
}




