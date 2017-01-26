//
//  EventByDateControllerViewController.swift
//  VzLife
//
//  Created by FOI on 26/01/17.
//  Copyright © 2017 varazdinevents. All rights reserved.
//

import UIKit

class EventByDateControllerViewController: UIViewController {

    
    var date = 0
    var events = [Event]()
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let dateEnd = self.datePicker.date
        let dateEndTimeInterval = dateEnd.timeIntervalSince1970
        let dateEndInt = Int(dateEndTimeInterval)
        
        let date = self.datePicker.date
        let date1 = date.addingTimeInterval(1440 * 60.0)
        print ("Ovo je datum", date1)
        
        let dateTimeInterval = date.timeIntervalSince1970
        let dateInInt = Int(dateTimeInterval)
        
        let events = Event()
        
        events.date_to = dateEndInt
        events.date = dateInInt
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eventViewPass(_ sender: Any) {
        
     /*   let dateEnd = self.datePicker.date
        let dateEndTimeInterval = dateEnd.timeIntervalSince1970
        let dateEndInt = Int(dateEndTimeInterval)*/
        
        let date = self.datePicker.date
        let date1 = date.addingTimeInterval(1440 * 60.0)
        print ("Ovo je datum", date1)
        print ("ovo je datum iznad: ", date)
        let dateTimeInterval = date.timeIntervalSince1970
        let dateInInt = Int(dateTimeInterval)
        
        let dateTimeIntervalDayAfter = date1.timeIntervalSince1970
        let dateDayAfter = Int(dateTimeIntervalDayAfter)
        
        let events = Event()
        
        events.date_to = dateDayAfter
        events.date = dateInInt
        print("Eventi", events.date_to )
        
        let goBackToCollectionView = self.storyboard?.instantiateViewController(withIdentifier:"eventsByDate") as! EventsByDateController
        goBackToCollectionView.event = events
        self.navigationController?.pushViewController(goBackToCollectionView, animated: true)


    }
  /*  @IBAction func goToEventView(_ sender: Any) {
    
    //need to set to event object
    
        
        let dateEnd = self.datePicker.date
        let dateEndTimeInterval = dateEnd.timeIntervalSince1970
        let dateEndInt = Int(dateEndTimeInterval)
        
        let date = self.datePicker.date
        let date1 = date.addingTimeInterval(1440 * 60.0)
        print ("Ovo je datum", date1)
        
        let dateTimeInterval = date.timeIntervalSince1970
        let dateInInt = Int(dateTimeInterval)
        
        let events = Event()
        
        events.date_to = dateEndInt
        events.date = dateInInt
        
        let dateFormatter = DateFormatter()
        let dateFormatter2 = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter2.dateFormat = "hh:mm:ss"
        
        //let stringTime = dateFormatter2.string(from: date)
        //let stringTimeTo = dateFormatter2.string(from: dateEnd)
        
        
        let goBackToCollectionView = self.storyboard?.instantiateViewController(withIdentifier:"giveDate") as! EventController
        goBackToCollectionView.events = self.events
        self.navigationController?.pushViewController(goBackToCollectionView, animated: true)
 */
        

}
