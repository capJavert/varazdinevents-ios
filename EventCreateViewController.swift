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
    
    
    var events = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eventCreateButton(_ sender: Any) {
        
        let events = Event()
        //need to set to event object
        events.title = self.eventTitle.text!
        events.text = self.eventAbout.text!
        let date = self.eventDate.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMDD000000"
        let stringDate = dateFormatter.string(from: date)
        events.date = Int(stringDate)!
     
    
        events.category = self.eventCategory.text!
        
       if(events.title.isEmpty){
            self.displayAlertMessage(userMessage: "Nije ispunjeno jedno od bitnih polja")
            return
        }
        
    }
    
    func displayAlertMessage(userMessage: String){
        
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
       
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


