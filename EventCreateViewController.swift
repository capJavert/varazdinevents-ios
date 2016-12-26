//
//  EventCreateViewController.swift
//  VzLife
//
//  Created by FOI on 26/12/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit

class EventCreateViewController: UIViewController {

    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventAbout: UITextField!
    @IBOutlet weak var eventDate: UIDatePicker!
    @IBOutlet weak var eventCategory: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eventCreateButton(_ sender: Any) {
        
        let title = self.eventTitle.text
        let about = self.eventAbout.text
        let date  = self.eventDate.date
        let category = self.eventCategory.text
        
        if((title?.isEmpty)! || (about?.isEmpty)! || (category?.isEmpty)!){
            displayAlertMessage(userMessage: "Nije ispunjeno jedno od bitnih polja")
            return
        }
        
    }
    
    func displayAlertMessage(userMessage: String){
        
        var alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
       
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
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
