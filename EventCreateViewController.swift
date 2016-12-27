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
    @IBOutlet weak var eventDateEnd: UIDatePicker!
    @IBOutlet weak var host: UITextField!
    @IBOutlet weak var facebookUrl: UITextField!
    @IBOutlet weak var offers: UITextField!
    var sessionId: String = ""
    var user =  User()
    
    
    
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
        
        
        /*var arrayOfEvents: [(title: String, text: String, facebook: String, offers: String, host: String, date: Int, dateEnd: Int, time: String, timeTo: String, category: String, image: String, officialLink: String)] = []*/
        
        let events = Event()
        //need to set to event object
        events.title = self.eventTitle.text!
        events.text = self.eventAbout.text!
        events.facebook = self.facebookUrl.text!
        events.offers = self.offers.text!
        events.host = self.host.text!
        let dateEnd = self.eventDateEnd.date
        let date = self.eventDate.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMDD000000"
        let stringDate = dateFormatter.string(from: date)
        let stringDateTo = dateFormatter.string(from: dateEnd)
        let dateFrom = Int(stringDate)!
        let date_to = Int(stringDateTo)!
        events.category = self.eventCategory.text!
        /*arrayOfEvents.append((tite: self.eventTitle.text!, text: self.eventAbout.text!, facebook: self.facebookUrl.text!, offers: self.offers.text!, host: self.host.text!,  date: dateFrom, dateEnd: date_to, time: "lala", timeTo: "lala", category: self.eventCategory.text!, image: "lala", officialLink: "lala") as! (title: String, text: String, facebook: String, offers: String, host: String, date: Int, dateEnd: Int, time: String, timeTo: String, category: String, image: String, officialLink: String))*/
        
        if(events.title.isEmpty){
            self.displayAlertMessage(userMessage: "Nije ispunjeno jedno od bitnih polja")
            return
        }

        let httpReq = HTTPRequest()
        httpReq.createEvent(data: ["title": events.title, "text": self.eventAbout.text!, "facebook": self.facebookUrl.text!, "offers": self.offers.text!, "host": self.host.text!,  "date": dateFrom, "dateEnd": date_to, "time": "lala", "timeTo": "lala", "category": self.eventCategory.text!, "image": "lala", "officialLink": "lala"] , sessionId: user.sessionId)
        
        
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


