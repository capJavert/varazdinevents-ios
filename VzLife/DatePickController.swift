//
//  DatePickController.swift
//  VzLife
//
//  Created by FOI on 26/01/17.
//  Copyright © 2017 varazdinevents. All rights reserved.
//

import UIKit

class DatePickController: UIViewController {

    
    var date = 0
    var events = [Event]()
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Odaberite vrijeme događaja"
        
        let dateEnd = self.datePicker.date
        let dateEndTimeInterval = dateEnd.timeIntervalSince1970
        let dateEndInt = Int(dateEndTimeInterval)
        let date = self.datePicker.date
        
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
        let dateTimeInterval = date.timeIntervalSince1970
        let dateInInt = Int(dateTimeInterval)
        
        let dateTimeIntervalDayAfter = date1.timeIntervalSince1970
        let dateDayAfter = Int(dateTimeIntervalDayAfter)
        
        let events = Event()
        
        events.date_to = dateDayAfter
        events.date = dateInInt
        
        let goBackToCollectionView = self.storyboard?.instantiateViewController(withIdentifier:"eventsByDate") as! EventDateController
        goBackToCollectionView.event = events
        self.navigationController?.pushViewController(goBackToCollectionView, animated: true)


    }
        

}
