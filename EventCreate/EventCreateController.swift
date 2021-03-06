//
//  EventCreateViewController.swift
//  VzLife
//
//  Created by FOI on 26/12/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit


/// Event Create View Controller
class EventCreateController: UIViewController, UITextFieldDelegate {

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
    var keyBoardObserverShow: Any? = nil
    var keyBoardObserverHide: Any? = nil
    
    @IBOutlet var uiView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var events = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: uiView.frame.size.height + 180)
        
        //hide keyboard on click
        self.hideKeyboardWhenTappedAround()
        
        self.host.delegate = self
        self.facebookUrl.delegate = self
        self.offers.delegate = self
        
        self.view.addSubview(scrollView)
        // Do any additional setup after loading the view.
        //scrollView.contentSize = CGSize(width: 0, height: 700)
        self.navigationItem.title = "Kreiraj događaj"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        keyBoardObserverShow = NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        keyBoardObserverHide = NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        let dateEndTimeInterval = dateEnd.timeIntervalSince1970
        let dateEndInt = Int(dateEndTimeInterval)
        
        let date = self.eventDate.date
        let dateTimeInterval = date.timeIntervalSince1970
        let dateInInt = Int(dateTimeInterval)
        
        
        let dateFormatter = DateFormatter()
        let dateFormatter2 = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter2.dateFormat = "hh:mm:ss"
        
        //let stringDate = dateFormatter.string(from: date)
        //let stringDateTo = dateFormatter.string(from: dateEnd)
        
        
        let stringTime = dateFormatter2.string(from: date)
        let stringTimeTo = dateFormatter2.string(from: dateEnd)

        
        events.category = self.eventCategory.text!
        /*arrayOfEvents.append((tite: self.eventTitle.text!, text: self.eventAbout.text!, facebook: self.facebookUrl.text!, offers: self.offers.text!, host: self.host.text!,  date: dateFrom, dateEnd: date_to, time: "lala", timeTo: "lala", category: self.eventCategory.text!, image: "lala", officialLink: "lala") as! (title: String, text: String, facebook: String, offers: String, host: String, date: Int, dateEnd: Int, time: String, timeTo: String, category: String, image: String, officialLink: String))*/
        
        if(events.title.isEmpty){
            self.displayAlertMessage(userMessage: "Nije ispunjeno jedno od bitnih polja")
            return
        }

        let httpReq = HTTPRequest()
        httpReq.createEvent(data: ["title": events.title, "text": events.text, "facebook": events.facebook, "offers": events.offers, "host": events.host,  "date": dateInInt, "date_to": dateEndInt, "time": stringTime, "time_to": stringTimeTo, "category": events.category, "image": "", "officialLink": ""] , sessionId: user.sessionId)
        
        let eventsView = self.storyboard?.instantiateViewController(withIdentifier: "eventsView") as! EventController
        eventsView.user = user
        let rootView = self.navigationController?.popToRootViewController(animated: false)
        self.navigationController?.pushViewController((rootView?[0])!, animated: false)
        
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


