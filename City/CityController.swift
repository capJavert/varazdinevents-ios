//
//  CityController.swift
//  VzLife
//
//  Created by FOI on 13/05/17.
//  Copyright © 2017 varazdinevents. All rights reserved.
//

import UIKit
import RealmSwift

class CityController:  UITableViewController{

    var city = [City] ()
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    
    @IBOutlet var tableViewController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewController.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        if(NetworkConnection.Connection.isConnectedToNetwork()){
            webServiceDataLoader.onCitiesLoadedDelegate = self
            webServiceDataLoader.LoadCities()
        }else{
            dbDataLoader.onCitiesLoadedDelegate = self
            dbDataLoader.LoadCities()
        }
        
        tableViewController.delegate = self
        tableViewController.dataSource = self
        self.navigationItem.title = "Odaberi grad"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("OVO JE JEBENI BROJ GRADOVA: ", city.count)
        return city.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = city[indexPath.item].name
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width + 10, height: 50))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
       

        return cell
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        do {
            try! realm.write() {
                city[indexPath.item].active = 1
                realm.add(city, update: true)
            }
        }
        performSegue(withIdentifier: "cityPick", sender: city[indexPath.item])

    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cityPick"{
            let cities = segue.destination as! EventController
            let sender = sender as! City
            cities.city = sender
        }
    }

}

extension CityController: OnCitiesLoadedDelegate{
    
    public func onCitiesLoaded(cities: [City]) {
        self.city = Array(DbController.sharedDBInstance.realm.objects(City.self))
        tableViewController.reloadData()
    }
}


