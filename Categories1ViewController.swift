//
//  Categories1ViewController.swift
//  VzLife
//
//  Created by FOI on 27/12/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {

    let categories = ["Kazalište i film", "Slušaona", "Svirka", "Volontiranje", " Tečaj", "Predavanje", "Party","Ostalo","Arhiva događaja"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  categories.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = categories[indexPath.row]
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
