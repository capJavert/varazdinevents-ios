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
        
        return city.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width + 10, height: 50))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        
        cell.textLabel?.text = city[indexPath.item].name
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
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


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CityController: OnCitiesLoadedDelegate{
    
    public func onCitiesLoaded(cities: [City]) {
        self.city = Array(DbController.sharedDBInstance.realm.objects(City.self))
        tableViewController.reloadData()
    }
}


